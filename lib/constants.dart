enum RegistrationValidation {
  okay,
  userName,
  email,
  phone,
  password,
  confirmPassword,
}

enum LoginResponse {
  passed,
  failed,
}

enum RegistrationResponse {
  alreadyRegistered,
  passed,
  failed,
}

enum SearchResponse {
  failed,
  successful,
  notFulfilled
}

enum RequestResponse {
  failed,
  alreadyRequested,
  successful,
}

enum RequestStatus {
  completed,
  pending,
  timedOut,
  unknown,
}

enum SearchFailedResponse {
  increaseRange,
  dropRequest
}