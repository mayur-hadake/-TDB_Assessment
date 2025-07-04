

import 'package:flutter/cupertino.dart';

String getErrorMessage(int? statusCode) {
  debugPrint("status come here $statusCode");
  switch (statusCode) {
    case 400:
      return "400 - Invalid credentials.";
    case 401:
      return "401 - Unauthorized. Please log in.";
    case 403:
      return "403 - You don't have permission to perform this action.";
    case 404:
      return "404 - Resource not found.";
    case 408:
      return "408 - Request timed out. Please try again.";
    case 429:
      return "429 - Too many requests. Try again later.";
    case 500:
      return "500 - Internal server error.";
    case 502:
      return "502 - Bad gateway.";
    case 503:
      return "503 - Service unavailable. Please try again later.";
    case 504:
      return "504 - Gateway timeout.";
    default:
      return "Something went wrong. Please try again.";
  }
}
