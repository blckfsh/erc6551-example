// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC6551Registry} from "../src/ERC6551Registry.sol";
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address erc6551Registry;
        uint256 deployerKey;
    }

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    constructor() {
        if (block.chainid == 80001) {
            activeNetworkConfig = getMumbaiConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getMumbaiConfig() public view returns (NetworkConfig memory mumbaiNetworkConfig) {
        mumbaiNetworkConfig = NetworkConfig({
            erc6551Registry: 0x000000006551c19487814612e58FE06813775758,
            deployerKey: vm.envUint("PRIVATE_KEY")
        });
    }

     function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory anvilNetworkConfig) {
        // Check to see if we set an active network config
        if (activeNetworkConfig.erc6551Registry != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        ERC6551Registry erc6551Registry = new ERC6551Registry();
        vm.stopBroadcast();

        anvilNetworkConfig = NetworkConfig({
            erc6551Registry: address(erc6551Registry),
            deployerKey: DEFAULT_ANVIL_PRIVATE_KEY
        });
     }
}