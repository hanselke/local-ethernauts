import { expect } from "chai";
import { ethers } from "hardhat";

let victim: any;
let attacker: any;
let hacker: any;
let deployer: any;
let kingPlayer: any;

describe("Attacking King", function () {
  beforeEach(async () => {
    [hacker, deployer, kingPlayer] = await ethers.getSigners();
    const Victim = await ethers.getContractFactory("King");
    victim = await Victim.connect(deployer).deploy({
      value: ethers.utils.parseEther("1"),
    });
    const Attacker = await ethers.getContractFactory("AttackingKing");
    attacker = await Attacker.connect(hacker).deploy(victim.address, {
      value: ethers.utils.parseEther("5"),
    });
  });

  // Get this to pass!
  it("Succesfully become and remain the king forever", async () => {
    let prize = await victim._prize();
    let balance = await ethers.provider.getBalance(victim.address);
    let contractBalance =  await ethers.provider.getBalance(attacker.address);
    console.log("before hackcontract",prize.toString(),balance.toString(),contractBalance.toString())

    await attacker.hackContract({ gasLimit: 30000000 });
    balance = await ethers.provider.getBalance(victim.address);
    prize = await victim._prize();
    console.log("after hackcontract",prize.toString(),balance,contractBalance.toString())
    try {
      await kingPlayer.sendTransaction({
        value: ethers.utils.parseEther("100"),
        to: victim.address,
        gasLimit: 30000000,
      });
    } catch (error) {
      console.log("error: ", error);
    }
    const king = await victim._king();
    expect(king).to.not.equal(kingPlayer.address);
  });
});
