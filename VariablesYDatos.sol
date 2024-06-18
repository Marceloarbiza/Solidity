// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {
    bool public myBool = true;
    int256 public myInt = -1;
    uint256 public myUint = 1;
    address public myAddress = 0x1234567890123456789012345678901234567890;
    bytes32 public myBytes32 = "Hello, Solidity!";
    string public myString = "Hello, World!";
    
    enum State { Waiting, Ready, Active }
    State public state;

    struct Person {
        string name;
        uint256 age;
    }

    Person public person = Person("John", 30);

    function setState(State _state) public {
        state = _state;
    }

    function setPerson(string memory _name, uint256 _age) public {
        person = Person(_name, _age);
    }
}
