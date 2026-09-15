// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {BuyHelper} from "../src/BuyHelper.sol";

interface ISaleCapExempt {
    function setCapExempt(address account, bool exempt) external;
}

/**
 * @notice Deploy BuyHelper to Sepolia.
 *
 *  Run:
 *    forge script script/DeployBuyHelper.s.sol \
 *      --rpc-url $SEPOLIA_RPC_URL2 \
 *      --private-key $PRIVATE_KEY_ANNI \
 *      --broadcast --verify
 */
contract DeployBuyHelper is Script {
    // Rebound to the canonical SuperPaymaster GToken/aPNTs (path A reconciliation,
    // 2026-06-21) + the freshly redeployed sale stack bound to those tokens.
    address constant USDC    = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address constant GTOKEN  = 0x20a051502a7AE6e40cfFd6EBe59057538E698984;
    address constant APNTS   = 0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b;
    address constant SALE_GT = 0xA563fA13E2353aE7D65FCE37F4801288CD11FC3e;
    address constant SALE_AP = 0x9cF028D17b40E5249Ce119a2E642A6eC91a285D0;

    function run() external returns (BuyHelper helper) {
        console.log("=== Deploying BuyHelper ===");
        console.log("Broadcaster:", msg.sender);
        console.log("USDC:       ", USDC);
        console.log("GTOKEN:     ", GTOKEN);
        console.log("APNTS:      ", APNTS);
        console.log("SALE_GT:    ", SALE_GT);
        console.log("SALE_AP:    ", SALE_AP);

        // 3 DVT relay operators (AAStarCommunity/dvt#5, Sepolia). Owner can
        // addRelayer/removeRelayer later without redeploying (rotation / new nodes).
        address[] memory relayers = new address[](3);
        relayers[0] = 0x214de9df4442e130F095083ECe3F67c8f2eaB6B7; // dvt1
        relayers[1] = 0x04abAC202DA0AE78a3ca5DFa1016066919792c5a; // dvt2
        relayers[2] = 0xA47db60B58eE7c7a4d04d44BdAd2A6e8b9A3653F; // dvt3
        address owner = vm.envAddress("OWNER_ADDRESS");
        require(owner != address(0), "OWNER_ADDRESS unset");
        console.log("Owner:      ", owner);
        console.log("Relayers:   3 DVT operators (dvt1/dvt2/dvt3)");

        vm.startBroadcast();
        helper = new BuyHelper(USDC, GTOKEN, APNTS, SALE_GT, SALE_AP, owner, relayers);
        // Exempt the helper from SaleContractV2's per-person cap. Without this,
        // every gasless buy aggregates under the helper's address and bricks at
        // $864. Requires the broadcaster to be SALE_GT's owner. (APNTsSaleContract
        // has no per-person cap, so no exemption is needed there.)
        ISaleCapExempt(SALE_GT).setCapExempt(address(helper), true);
        vm.stopBroadcast();

        console.log("");
        console.log("BuyHelper deployed at:", address(helper));
        console.log("DOMAIN_SEPARATOR:", uint256(helper.DOMAIN_SEPARATOR()));
        console.log("");
        console.log("=== Next steps ===");
        console.log("1. Update services/relayer/src/rules/whitelist.ts with BUY_HELPER");
        console.log("2. Update services/relayer/wrangler.toml with BUY_HELPER");
        console.log("3. Update site/join-gasless.html with BUY_HELPER constant");
        console.log("4. Update docs/gasless-eoa-enhance/02-architecture-decision-eip3009.md");
    }
}
