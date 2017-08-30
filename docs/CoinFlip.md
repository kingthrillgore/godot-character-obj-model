# Coin flip

For instances where I needed a more relative chance mechanism, I felt a non-approximate coin flip was appropriate. It doesn't actually account for any actual physical attributes, but uses a xorshift128 generated integer.

Everything should be self-explanatory in `CoinFlip.gd`.

## Other Notes

* At some point I would like to look at what value I gain by exploiting the Physics system to emulate a 2-Euro coin for this behavior.
