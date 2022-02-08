// require contract instance
const HelloWorld = artifacts.require("HelloWorld");
const HelloWorldClone = artifacts.require("HelloWorldClone");

module.exports = function (deployer) {
  // deploy mehtod requires contract and its constructor
  deployer.deploy(HelloWorld, "hello world constructor")
          // deploy two contracts in one migration
          .then(() => {
            return deployer.deploy(HelloWorldClone);
          });
};
