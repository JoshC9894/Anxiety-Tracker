const bleno = require("bleno");

const Service_Name = "Anxiety-Tracker-Service";
const Service_GUID = "bb432abe-7ba2-488f-8a9d-7b2d63a12ad1"

const BlenoService = bleno.PrimaryService;
const ButtonCharacteristic = require('./source/ButtonCharacteristic');

bleno.on('stateChange', function (state) {
    if (state === 'poweredOn') {
        bleno.startAdvertising(Service_Name, [Service_GUID]);
    } else {
        bleno.stopAdvertising();
    }
});

bleno.on('advertisingStart', function (error) {
    if (!error) {
        bleno.setServices([
            new BlenoService({
                uuid: Service_GUID,
                characteristics: [
                    new ButtonCharacteristic()
                ]
            })
        ]);
    }
});