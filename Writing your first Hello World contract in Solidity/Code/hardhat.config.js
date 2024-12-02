/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 require('dotenv').config(); //all the key value pairs are being made available due to this lib
 require('@nomiclabs/hardhat-ethers');

 const {API_URL_KEY, PRIVATE_KEY} = process.env; //environment variables are being loaded here.

 module.exports = {
   solidity: "0.7.3",
   defaultNetwork: 'rinkeby', //simulation of ethereum blockchain.
   networks: {
     hardhat: {},
     rinkeby: {
         url: API_URL_KEY,
         accounts: [`0x${PRIVATE_KEY}`]
     }
   }
 };