// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

// Demo deployments
// Goerli 0x09A02586dAf43Ca837b45F34dC2661d642b8Da15
// https://goerli-optimism.etherscan.io/address/0x09a02586daf43ca837b45f34dc2661d642b8da15#code

import {Script} from "forge-std/Script.sol";
import {PolygonWorldID} from "src/PolygonWorldID.sol";

contract DeployPolygonWorldIDMumbai is Script {
    address public stateBridgeAddress;

    // Polygon PoS Mumbai Testnet Child Tunnel
    address public fxChildAddress = address(0xCf73231F28B7331BBe3124B907840A94851f9f11);

    PolygonWorldID public polygonWorldId;
    uint256 public privateKey;

    uint8 public treeDepth;

    /*//////////////////////////////////////////////////////////////
                                CONFIG
    //////////////////////////////////////////////////////////////*/
    string public root = vm.projectRoot();
    string public path = string.concat(root, "/src/script.deploy-config.json");
    string public json = vm.readFile(path);

    function setUp() public {
        privateKey = abi.decode(vm.parseJson(json, ".privateKey"), (uint256));
        treeDepth = abi.decode(vm.parseJson(json, ".treeDepth"), (uint8));
    }

    function run() external {
        vm.startBroadcast(privateKey);

        polygonWorldId = new PolygonWorldID(treeDepth, fxChildAddress);

        vm.stopBroadcast();
    }
}