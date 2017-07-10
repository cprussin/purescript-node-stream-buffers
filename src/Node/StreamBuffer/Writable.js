"use strict";

/**
 * Returns a writable stream buffer factory.
 */
exports.writable = function () {
  var WritableStreamBuffer = require("stream-buffers").WritableStreamBuffer;
  return new WritableStreamBuffer();
};

/**
 * Given an encoding string and a writable stream buffer, returns the contents
 * of that stream buffer.
 */
exports.contentsImpl = function (enc) {
  return function (w) {
    return function () {
      return w.getContentsAsString(enc);
    };
  };
};
