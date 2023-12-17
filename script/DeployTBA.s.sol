// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {ERC6551Account} from "../src/ERC6551Account.sol";

contract DeployTBA is Script {
    string s_baseURI = "";

    function run() external returns (MyNFT, ERC6551Account, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!

        (,uint256 deployerKey) = helperConfig.activeNetworkConfig();

        vm.startBroadcast(deployerKey);
        MyNFT myNFT = new MyNFT(s_baseURI);
        ERC6551Account erc6551Account = new ERC6551Account();
        vm.stopBroadcast();

        return (myNFT, erc6551Account, helperConfig);
    }
}