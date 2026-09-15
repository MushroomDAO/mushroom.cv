// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";
import {APNTsSaleContract} from "../src/APNTsSaleContract.sol";

/**
 * @notice Deploys BOTH sale contracts for the gasless EOA-enhance feature:
 *  - SaleContractV2-NEW: binds to the verified gToken (replaces MockGToken-bound version)
 *  - APNTsSaleContract:  binds to verified aPNTs
 *
 *  Inventory transfers happen separately (via cast) because tokens are held by
 *  the protocol deployer EOA, not ANNI.
 *
 *  Required env:
 *    GTOKEN_ADDRESS        - The verified gToken (Sepolia: 0x4e6A1125...)
 *    APNTS_ADDRESS         - The verified aPNTs   (Sepolia: 0x4C4EC2e8...)
 *    USDC_ADDRESS          - USDC Sepolia (0x1c7D4B19...)
 *    TREASURY_ADDRESS      - Optimism Safe (0x51eDf11f...)
 *    OWNER_ADDRESS         - ANNI (0xEcAACb91...)
 *
 *  Run:
 *    forge script script/DeployGaslessSaleStack.s.sol \
 *      --rpc-url $SEPOLIA_RPC_URL2 \
 *      --private-key $PRIVATE_KEY_ANNI \
 *      --broadcast --verify
 */
contract DeployGaslessSaleStack is Script {
    function run() external returns (SaleContractV2 saleV2, APNTsSaleContract apntsSale) {
        address gToken    = vm.envAddress("GTOKEN_ADDRESS");
        address apnts     = vm.envAddress("APNTS_ADDRESS");
        address usdc      = vm.envAddress("USDC_ADDRESS");
        address treasury  = vm.envAddress("TREASURY_ADDRESS");
        address owner     = vm.envAddress("OWNER_ADDRESS");
        // Optional: accept USDT too (self-pay path — USDT has no EIP-3009 so it
        // can't go gasless, but buyTokensFor/buyAPNTsFor let it buy into AirAccount).
        // Must be a 6-decimal stablecoin (setPaymentToken enforces this).
        address usdt      = vm.envOr("USDT_ADDRESS", address(0));

        require(gToken != address(0), "GTOKEN_ADDRESS unset");
        require(apnts != address(0), "APNTS_ADDRESS unset");
        require(usdc != address(0), "USDC_ADDRESS unset");
        require(treasury != address(0), "TREASURY_ADDRESS unset");
        require(owner != address(0), "OWNER_ADDRESS unset");

        console.log("=== Gasless Sale Stack Deployment ===");
        console.log("gToken (verified): ", gToken);
        console.log("aPNTs  (verified): ", apnts);
        console.log("USDC payment:      ", usdc);
        console.log("Treasury:          ", treasury);
        console.log("Owner (ANNI):      ", owner);

        vm.startBroadcast();

        // 1. SaleContractV2 bound to verified gToken
        saleV2 = new SaleContractV2(gToken, treasury, owner);
        saleV2.setPaymentToken(usdc, true);
        if (usdt != address(0)) saleV2.setPaymentToken(usdt, true);
        saleV2.setWhitelistRequired(false);
        console.log("SaleContractV2 (gToken):", address(saleV2));

        // 2. APNTsSaleContract — default price $0.02 (20_000 6dec)
        apntsSale = new APNTsSaleContract(
            apnts,
            treasury,
            20_000, // $0.02 per aPNTs
            owner
        );
        apntsSale.setPaymentToken(usdc, true);
        if (usdt != address(0)) apntsSale.setPaymentToken(usdt, true);
        console.log("APNTsSaleContract: ", address(apntsSale));

        vm.stopBroadcast();

        console.log("");
        console.log("=== Next: transfer inventory from deployer ===");
        console.log("From deployer (0xb5600060...):");
        console.log("  gToken.transfer(SaleV2,     100e18)   // 100 GT for tests");
        console.log("  aPNTs.transfer(APNTsSale,   1000e18)  // 1000 aPNTs for tests");
    }
}
