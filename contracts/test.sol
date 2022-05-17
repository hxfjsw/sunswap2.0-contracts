pragma solidity >=0.6.6;

import './interfaces/ISunswapV2Factory.sol';
import './lib/contracts/libraries/TransferHelper.sol';
import './interfaces/ISunswapV2Router02.sol';
import './libraries/SunswapV2Library.sol';
import './libraries/SafeMath.sol';
import './interfaces/IERC20.sol';
import './interfaces/IWETH.sol';

contract SunswapV2Router02 {
    using SafeMath for uint;

    address public immutable  factory;
    address public immutable  WETH;

    modifier ensure(uint deadline) {
        require(deadline >= block.timestamp, 'SunswapV2Router: EXPIRED');
        _;
    }

    constructor(address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
    }

    receive() external payable {
        assert(msg.sender == WETH);
        // only accept ETH via fallback from the WETH contract
    }

    function testGetReserves(address tokenA, address tokenB) external view returns (uint reserveA, uint reserveB)
    {
        (reserveA, reserveB) = SunswapV2Library.getReserves(factory, tokenA, tokenB);
    }

//    function testGetReserves2(uint amountADesired,
//        uint amountBDesired, uint amountAMin, int amountBMin, address tokenA, address tokenB)
//    external view returns (uint amountA, uint amountB)
//    {
//        (uint reserveA, uint reserveB) = SunswapV2Library.getReserves(factory, tokenA, tokenB);
//        if (reserveA == 0 && reserveB == 0) {
//            (amountA, amountB) = (amountADesired, amountBDesired);
//        } else {
//            uint amountBOptimal = SunswapV2Library.quote(amountADesired, reserveA, reserveB);
//            if (amountBOptimal <= amountBDesired) {
//                require(amountBOptimal >= amountBMin, 'SunswapV2Router: INSUFFICIENT_B_AMOUNT');
//                (amountA, amountB) = (amountADesired, amountBOptimal);
//            } else {
//                uint amountAOptimal = SunswapV2Library.quote(amountBDesired, reserveB, reserveA);
//                require(amountAOptimal <= amountADesired, "amountAOptimal <= amountADesired");
//                require(amountAOptimal >= amountAMin, 'SunswapV2Router: INSUFFICIENT_A_AMOUNT');
//                (amountA, amountB) = (amountAOptimal, amountBDesired);
//            }
//        }
//    }


    // calculates the CREATE2 address for a pair without making any external calls
    function testPairFor(address factory, address tokenA, address tokenB) external pure returns (address) {
        return SunswapV2Library.pairFor(factory,tokenA,tokenB);
    }

}