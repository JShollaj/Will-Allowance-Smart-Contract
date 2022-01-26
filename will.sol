pragma solidity >=0.7.0 <0.9.0;

//Beginner Project
//Creating a smart contract which will
//Send the fortune after a relative passes away

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _; 
    } 

    modifier allocateFunds {
        require(deceased == true);
        _;
    }



    address payable[] familyWallets; // Store all wallets

    mapping(address => uint) inheritance;

    function setInheritance(address payable wallet, uint amount) public {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    //Automate payment based on wallet address
    function payOut() private allocateFunds {
        for(uint i=0;i<familyWallets.length;i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        
        }
    }

    //Oracle simulated switch
    function Hasdeceased() public onlyOwner{
        deceased = true;
        payOut();

    }

    } 

