function [zpetcFf, zohPlt, zpetcRef] = zpetc(cntPlt,samplingTs)
  zohPlt = c2d(cntPlt, samplingTs, 'zoh');
  dstZeroList = zero(zohPlt);
  nonAcceptableZero = dstZeroList(abs(dstZeroList) >= 1);
  nonAcceptableZeroCnt = length(nonAcceptableZero);
  nonAcceptablePoly = poly(nonAcceptableZero);
  zpetcRefNumeratorPoly = conv(nonAcceptablePoly, fliplr(nonAcceptablePoly));

  zpetcRefGain = polyval(nonAcceptablePoly, 1)^2;

  z = tf('z');
  zpetcRef = tf(zpetcRefNumeratorPoly, zpetcRefGain, samplingTs)/z^1;
  % divided z^'1' because |CB| neq 0
  zpetcFf = zpetcRef/zohPlt/z^(nonAcceptableZeroCnt + 1);
end

