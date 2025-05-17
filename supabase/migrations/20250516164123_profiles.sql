-- Create a table for public profiles
create table profiles (
  id uuid not null primary key references auth.users on delete cascade,
  email text unique not null,
  first_name text not null,
  last_name text not null,
  avatar_url text default 'https://avatars.sensazionapp.ddulce.app/unknown.avif',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Set up Row Level Security (RLS)
-- See https://supabase.com/docs/guides/auth/row-level-security for more details.
alter table profiles enable row level security;

create policy "Public profiles are viewable by everyone." on profiles for select using (true);

create policy "Users can insert their own profile." on profiles for insert
with check (auth.uid() = id);

create policy "Users can update their own profile." on profiles
for update using (auth.uid() = id);

-- Check if a user exists by their ID
-- Usage: select user_exists('1fb4a500-c123-41ed-bb09-a653f1ec417d');
create function public.user_exists(user_id uuid)
returns boolean
set search_path = ''
language sql
stable
security invoker
as $$
select exists (
  select 1
  from public.profiles
  where id = user_id
);
$$;

-- This trigger automatically sets a new updated_at timestamp for a profile entry when it is updated.
-- See https://supabase.com/docs/guides/auth/managing-user-data#using-triggers for more details.
create function public.handle_profile_update()
returns trigger
set search_path = ''
language plpgsql
security invoker
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger on_profile_updated
before update on public.profiles for each row
execute procedure public.handle_profile_update();

-- This trigger automatically creates a profile entry when a new user signs up via Supabase Auth.
-- See https://supabase.com/docs/guides/auth/managing-user-data#using-triggers for more details.
create function public.handle_new_user()
returns trigger
set search_path = ''
language plpgsql
security definer
as $$
begin
  insert into public.profiles (id, email, first_name, last_name)
  values (
    new.id,
    new.email,
    new.raw_user_meta_data->>'first_name',
    new.raw_user_meta_data->>'last_name'
  );
  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users for each row
execute procedure public.handle_new_user();