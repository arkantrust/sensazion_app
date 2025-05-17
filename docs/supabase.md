# Database Management

Supabase is an open-source Firebase alternative that provides a suite of tools for building applications, including a PostgreSQL database, authentication, and real-time capabilities.

## Migrations

To create a new migration file:

``` bash
supabase migration new migration_name
```

### Local Development

``` bash
# Start local Supabase instance
supabase start

# Your migration will automatically run when you start
# Or manually run migrations:
supabase db reset
```

### Cloud Deployment

``` bash
# Link to the cloud project
supabase link --project-ref our-project-ref

# Push migrations to cloud
supabase db push

# Or alternatively, copy the SQL and run it in the Supabase Dashboard > SQL Editor
```