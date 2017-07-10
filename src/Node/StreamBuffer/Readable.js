"use strict";

/**
 * Returns a readable stream buffer factory.
 */
exports.readable = function () {
  var ReadableStreamBuffer = require("stream-buffers").ReadableStreamBuffer;
  return new ReadableStreamBuffer();
};

/**
 * Given a readable stream buffer, an encoding string and a contents string,
 * writes the contents to the buffer.
 */
exports.putImpl = function (r) {
  return function (enc) {
    return function (str) {
      return function () {
        r.put(str, enc);
      };
    };
  };
};
