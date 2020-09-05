const util = require('util');
const bleno = require('bleno');

const Characteristic_GUID = "2160fa56-32a1-4121-a943-811e4b433a5d";

var BlenoCharacteristic = bleno.Characteristic;

getValue = () => {
    const json = JSON.stringify({ text: "Message from IoT Device"});
    buffer = new Buffer(json.length);
    buffer.write(json);
    console.log(json);
    console.log(buffer);
    return buffer;
}

var ButtonCharacteristic = function () {
    ButtonCharacteristic.super_.call(this, {
        uuid: Characteristic_GUID,
        properties: ['read', 'write', 'notify'],
        value: null
    });
    this._value = getValue();
    this._updateValueCallback = null;
};

util.inherits(ButtonCharacteristic, BlenoCharacteristic);

ButtonCharacteristic.prototype.onReadRequest = function (offset, callback) {
    console.log('ButtonCharacteristic - onReadRequest: value = ' + this._value.toString('hex'));
    callback(this.RESULT_SUCCESS, this._value);
}

ButtonCharacteristic.prototype.onWriteRequest = function (data, offset, withoutResponse, callback) {
    this._value = data;
    console.log('ButtonCharacteristic - onWriteRequest: value = ' + this._value.toString('hex'));

    if (this._updateValueCallback) {
        console.log('ButtonCharacteristic - onWriteRequest: notifying');

        this._updateValueCallback(this._value);
    }

    callback(this.RESULT_SUCCESS);
}

ButtonCharacteristic.prototype.onSubscribe = function (maxValueSize, updateValueCallback) {
    console.log('ButtonCharacteristic - onSubscribe');
    this._updateValueCallback = updateValueCallback;
}

ButtonCharacteristic.prototype.onUnsubscribe = function () {
    console.log('ButtonCharacteristic - onUnsubscribe');
    this._updateValueCallback = null;
}

module.exports = ButtonCharacteristic;