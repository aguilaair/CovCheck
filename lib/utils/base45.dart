// Code by https://github.com/calvinchengx/base45

// MIT License

// Copyright (c) 2021 Calvin Cheng

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:typed_data';

/// Base45 is an encoding that is compact and efficient for use in QR code.
/// It should mostly be used for QR code.
/// It is not intended for use in URLs, for example.
class Base45 {
  static const int baseSize = 45;
  static const int baseSizeSquared = 2025;
  static const int chunkSize = 2;
  static const int encodedChunkSize = 3;
  static const int smallEncodedChunkSize = 2;
  static const int byteSize = 256;

  static const List<String> encoding = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    ' ',
    '\$',
    '%',
    '*',
    '+',
    '-',
    '.',
    '/',
    ':'
  ];

  static Map<String, int> decoding = <String, int>{};

  static Uint8List decode(String input) {
    if (input.isEmpty) {
      return Uint8List(0);
    }

    var remainderSize = input.length % encodedChunkSize;
    if (remainderSize == 1) {
      throw ArgumentError.value(input, 'input', 'has incorrect length');
    }

    if (decoding.keys.isEmpty) {
      for (var i = 0; i < encoding.length; ++i) {
        decoding[encoding[i]] = i;
      }
    }

    var buffer = Uint8List(input.length);
    for (var i = 0; i < input.length; ++i) {
      var found = decoding[input[i]];
      if (null == found) {
        throw Exception('Invalid character at position $i.');
      }
      buffer[i] = found;
    }

    var wholeChunkCount = (buffer.length / encodedChunkSize).truncate();

    var result = Uint8List(
        wholeChunkCount * chunkSize + (remainderSize == chunkSize ? 1 : 0));
    var resultIndex = 0;
    var wholeChunkLength = wholeChunkCount * encodedChunkSize;
    for (var i = 0; i < wholeChunkLength;) {
      var val =
          buffer[i++] + baseSize * buffer[i++] + baseSizeSquared * buffer[i++];
      result[resultIndex++] = (val / byteSize)
          .truncate(); //result is always in the range 0-255 - % ByteSize omitted.
      result[resultIndex++] = val % byteSize;
    }

    if (remainderSize == 0) return result;

    result[result.length - 1] = buffer[buffer.length - 2] +
        baseSize *
            buffer[buffer.length -
                1]; //result is always in the range 0-255 - % ByteSize omitted.
    return result;
  }

  static String encode(Uint8List byteArrayArg) {
    if (byteArrayArg.isEmpty) {
      throw Exception('byteArrayArg is null or undefined');
    }

    var wholeChunkCount = (byteArrayArg.length / chunkSize).truncate();

    var resultSize = wholeChunkCount * encodedChunkSize +
        (byteArrayArg.length % chunkSize == 1 ? smallEncodedChunkSize : 0);

    if (resultSize == 0) {
      return '';
    }

    var result = List<String>.generate(resultSize, (index) => '');
    var resultIndex = 0;
    var wholeChunkLength = wholeChunkCount * chunkSize;
    for (var i = 0; i < wholeChunkLength;) {
      var value = byteArrayArg[i++] * byteSize + byteArrayArg[i++];
      result[resultIndex++] = encoding[value % baseSize];
      result[resultIndex++] =
          encoding[(value / baseSize).truncate() % baseSize];
      result[resultIndex++] =
          encoding[(value / baseSizeSquared).truncate() % baseSize];
    }

    if (byteArrayArg.length % chunkSize == 0) {
      return result.join('');
    }

    result[result.length - 2] =
        encoding[byteArrayArg[byteArrayArg.length - 1] % baseSize];
    result[result.length - 1] = byteArrayArg[byteArrayArg.length - 1] < baseSize
        ? encoding[0]
        : encoding[
            (byteArrayArg[byteArrayArg.length - 1] / baseSize).truncate() %
                baseSize];

    return result.join('');
  }
}
