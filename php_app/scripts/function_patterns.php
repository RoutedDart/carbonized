<?php

/**
 * Common Locale Function Patterns
 * 
 * This library contains common patterns for locale functions
 * that can be auto-generated to Dart equivalents.
 */

class LocaleFunctionPatterns
{
    /**
     * French ordinal pattern
     * PHP: match ($period) { 'D' => $number.($number === 1 ? 'er' : ''), default => ... }
     */
    public static function frenchOrdinal(): string
    {
        return <<<'DART'
String ordinal(int number, String period) {
  if (period == 'D') {
    return number == 1 ? '${number}er' : '$number';
  }
  if (period == 'w' || period == 'W') {
    return number == 1 ? '${number}re' : '${number}e';
  }
  return number == 1 ? '${number}er' : '${number}e';
}
DART;
    }
    
    /**
     * Russian ordinal pattern
     * PHP: match ($period) { 'M', 'd', 'DDD', 'w', 'W' => $number.'-й', 'D' => $number.'-го', default => $number }
     */
    public static function russianOrdinal(): string
    {
        return <<<'DART'
String ordinal(int number, String period) {
  if (period == 'M' || period == 'd' || period == 'DDD' || period == 'w' || period == 'W') {
    return '$number-й';
  }
  if (period == 'D') {
    return '$number-го';
  }
  return '$number';
}
DART;
    }
    
    /**
     * Default AM/PM meridiem
     */
    public static function defaultMeridiem(): string
    {
        return <<<'DART'
String meridiem(int hour) {
  return hour < 12 ? 'AM' : 'PM';
}
DART;
    }
    
    /**
     * Russian meridiem (time of day)
     * PHP: if ($hour < 4) return 'ночі'; elseif ($hour < 12) return 'ранку'; ...
     */
    public static function russianMeridiem(): string
    {
        return <<<'DART'
String meridiem(int hour) {
  if (hour < 4) return 'ночі';
  if (hour < 12) return 'ранку';
  if (hour < 17) return 'дня';
  return 'вечора';
}
DART;
    }
    
    /**
     * Get all available patterns
     */
    public static function getAllPatterns(): array
    {
        return [
            'ordinal' => [
                'fr' => self::frenchOrdinal(),
                'ru' => self::russianOrdinal(),
            ],
            'meridiem' => [
                'default' => self::defaultMeridiem(),
                'ru' => self::russianMeridiem(),
            ],
        ];
    }
}
