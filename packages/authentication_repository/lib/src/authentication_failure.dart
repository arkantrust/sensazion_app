class EmailNotFound implements Exception {
  const EmailNotFound();
}

class EmailAlreadyExists implements Exception {
  const EmailAlreadyExists();
}

class WrongPassword implements Exception {
  const WrongPassword();
}

class WeakPassword implements Exception {
  const WeakPassword();
}

class NoSessionFound implements Exception {
  const NoSessionFound();
}
