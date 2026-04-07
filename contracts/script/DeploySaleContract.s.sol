// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {SaleContract} from "../src/SaleContract.sol";

contract DeploySaleContract is Script {
    // Sepolia Circle USDC
    address constant USDC_SEPOLIA = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;

    function run() external returns (SaleContract) {
        // GToken — defaults to Sepolia SuperPaymaster standard deployment
        address gTokenAddress =
            vm.envOr("GTOKEN_ADDRESS", address(0xa592eC5a05C3909917d038AB01AAF7bcCF2D90f0));

        address treasuryAddress = vm.envAddress("TREASURY_ADDRESS");
        address ownerAddress = vm.envOr("OWNER_ADDRESS", msg.sender);

        // Optional: Sepolia USDT (set USDT_SEPOLIA in .env if available)
        address usdtSepolia = vm.envOr("USDT_SEPOLIA", address(0));

        require(gTokenAddress != address(0), "GTOKEN_ADDRESS not set");
        require(treasuryAddress != address(0), "TREASURY_ADDRESS not set");

        console.log("=== SaleContract Deployment ===");
        console.log("GToken address:  ", gTokenAddress);
        console.log("Treasury:        ", treasuryAddress);
        console.log("Owner:           ", ownerAddress);
        console.log("USDC (Sepolia):  ", USDC_SEPOLIA);

        vm.startBroadcast();

        SaleContract saleContract = new SaleContract(gTokenAddress, treasuryAddress, ownerAddress);

        // Accept USDC on Sepolia
        saleContract.setPaymentToken(USDC_SEPOLIA, true);
        console.log("Accepted USDC:   ", USDC_SEPOLIA);

        // Accept USDT if configured
        if (usdtSepolia != address(0)) {
            saleContract.setPaymentToken(usdtSepolia, true);
            console.log("Accepted USDT:   ", usdtSepolia);
        }

        // Disable whitelist — open sale
        saleContract.setWhitelistRequired(false);
        console.log("Whitelist:       disabled (open sale)");

        vm.stopBroadcast();

        console.log("SaleContract deployed at:", address(saleContract));
        console.log("Current milestone: 0 (Phase initial, price $0.15)");

        return saleContract;
    }
}
