// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Roles {
    address public admin;
    mapping(address => bool) public editors;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not the admin");
        _;
    }

    modifier onlyEditor() {
        require(editors[msg.sender], "Not an editor");
        _;
    }

    function addEditor(address _editor) public onlyAdmin {
        editors[_editor] = true;
    }

    function removeEditor(address _editor) public onlyAdmin {
        editors[_editor] = false;
    }

    function editData() public onlyEditor {
        // Editor-specific logic
    }
}
