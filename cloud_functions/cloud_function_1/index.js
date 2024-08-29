const functions = require('@google-cloud/functions-framework');
const { Firestore } = require('@google-cloud/firestore');

const firestore = new Firestore();

functions.http('cloud_function_1', async (req, res) => {
    console.log(`Starting cloudFunction2.`);

    // get the region record
    const regionRecord = await firestore.collection('regions').where('map_level', '==', 'Level1').get();

    if (regionRecord.empty) {
        res.status(404).send({ message: 'No records found.'});
    }

    res.status(200).send({ message: 'Found the record.'});
});