const {assert} = require("chai");

const KryptoHamster = artifacts.require("./KryptoHamster");

//check for chai
require("chai")
.use(require("chai-as-promised"))
.should()

contract("KryptoHamster", (accounts) => {
    let contract, KHamsterz, totalSupply, results
    const [owner, acc1, acc2] = accounts


    before( async() =>{
        contract = await KryptoHamster.new()
    })

    describe("Krypto Hamster NFT deployment", async() =>{
        
        it("deploys successfully", async() => {
            const address = contract.address
            assert.notEqual(address, "")
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it("token name matches successfully", async() => {
            let tokenName = await contract.name()
            assert.equal(tokenName, "KryptoHamster")
        })

        it("token symbol matches successfully", async() => {
            let tokenSymbol = await contract.symbol()
            assert.equal(tokenSymbol, "HAMI")
        })

    })

    describe("Minting Token Test", async() => {
        it("created a new token", async() => {
            result = await contract.mint("https...1")
            totalSupply = await contract.totalSupply()
            assert.equal(totalSupply, 1)

            // Success
            const event = await result.logs[0].args
            assert.equal(event.from, "0x0000000000000000000000000000000000000000", "from is the contract")
            assert.equal(event.to, owner, "to is the owner address")

            // Failure
            await contract.mint("https...1").should.be.rejected
        })
    })

    describe("Indexing Test", async() => {
        it("lists KryptoHamsterz", async () => {
            await contract.mint("https...2")
            await contract.mint("https...3")
            await contract.mint("https...4")
            totalSupply = await contract.totalSupply()

            // Loop through list and grab KHamsterz from list
            results = []
            for(i = 0; i < totalSupply; i++) {
                KHamsterz = await contract.kryptoHamsters(i)
                results.push(KHamsterz)
            }

            let expected = ["https...1","https...2","https...3","https...4"]
            assert.equal(results.join(","), expected.join(","))

        })
    })

    describe("Burning Token Test", async() => {
        it("burning a token", async() => {
            results = await contract.burn(0)
            totalSupply = await contract.totalSupply()
            assert.equal(totalSupply,3)
            const event = await results.logs[1].args
            assert.equal(event.from, owner, "from is the owner address")
            assert.equal(event.to, "0x0000000000000000000000000000000000000000", "to is the address 0")

            await contract.burn(1)
            totalSupply = await contract.totalSupply()
            assert.equal(totalSupply,2)

    
        })
        
        
    })

    

})