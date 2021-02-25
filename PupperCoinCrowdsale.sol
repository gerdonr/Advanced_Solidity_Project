{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "pragma solidity ^0.5.0;\n",
    "\n",
    "import \"./PupperCoin.sol\";\n",
    "import \"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol\";\n",
    "import \"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol\";\n",
    "import \"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol\";\n",
    "import \"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol\";\n",
    "import \"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol\";\n",
    "\n",
    "// Inherit the crowdsale contracts\n",
    "contract PupperCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundableCrowdsale, RefundablePostDeliveryCrowdsale {\n",
    "\n",
    "    constructor(\n",
    "        uint rate, // rate in PupperCoins\n",
    "        PupperCoin token,  // name of token\n",
    "        address payable wallet, // where sale proceeds will go\n",
    "        uint goal, // goal for crowdsale\n",
    "        uint open,\n",
    "        uint close,\n",
    "        uint cap\n",
    "    )\n",
    "        \n",
    "    Crowdsale(rate, wallet, token)\n",
    "    TimedCrowdsale(now, now + 24 weeks)\n",
    "    CappedCrowdsale(cap)\n",
    "    RefundableCrowdsale(goal)\n",
    "    RefundablePostDeliveryCrowdsale()\n",
    "    public\n",
    "    \n",
    "    {\n",
    "        // constructor can stay empty\n",
    "    }\n",
    "}\n",
    "\n",
    "contract PupperCoinSaleDeployer {\n",
    "\n",
    "    address public token_sale_address;\n",
    "    address public token_address;\n",
    "\n",
    "\n",
    "    constructor(\n",
    "        \n",
    "        string memory name,\n",
    "        string memory symbol,\n",
    "        address payable wallet // sale beneficiary\n",
    "    )\n",
    "        public\n",
    "    {\n",
    "        // @TODO: create the PupperCoin and keep its address handy\n",
    "        PupperCoin token = new PupperCoin(name, symbol, 0);\n",
    "        token_address = address(token);\n",
    "\n",
    "        // create the PupperCoinSale, atell it about token, set goal, and set open and close times to now and now + 24 weeks.\n",
    "        uint goal = 300;\n",
    "        uint cap = 300;\n",
    "        PupperCoinCrowdsale token_sale = new PupperCoinCrowdsale(1, token, wallet, goal, cap, now, now + 24 weeks);\n",
    "        token_sale_address = address(token_sale);\n",
    "        \n",
    "        \n",
    "\n",
    "        // make PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role\n",
    "        token.addMinter(token_sale_address);\n",
    "        token.renounceMinter();\n",
    "    }\n",
    "}"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.7.7"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
