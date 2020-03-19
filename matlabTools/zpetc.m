function [zpetcCtrl, stepShifter] = getZpetcFromPlant(dstPlt, unstableCond)
  if nargin == 1
    unstableCond = 1;
  end
  T = dstPlt.T;
  [den, B_s, bAsteriskVec] = prepare(dstPlt, unstalbeCond);
  B_s0 = polyval(B_s, 0);
  zpetcCtrl = tf(den, B_s, T)*tf(bAsteriskVec, B_s0^2, T);

  z = tf('z', T);
  relativeDegree = length(pole(dstPlt)) - length(zero(dstPlt));
  unstableZeroCnt = length(B_s) - 1;
  stepShifter = z^(-(relativeDegree + unstableZeroCnt));
end

function [zmetcCtrl, stepShifter] = getZmetcFromPlant(dstPlt, unstableCond)
  if nargin == 1
    unstableCond = 1;
  end
  T = dstPlt.T;
  [den, B_s, bAsteriskVec] = prepare(dstPlt, unstalbeCond);
  zmetcCtrl = tf(den, B_s, T)*tf(1, bAsteriskVec);

  z = tf('z', T);
  relativeDegree = length(pole(dstPlt)) - length(zero(dstPlt));
  stepShifter = z^(-(relativeDegree));
end

function [den, B_s, bAsteriskVec] = prepare(dstPlt, unstalbeCond)
  T = dstPlt.T;
  [num, den] = tfdata(dstPlt, 'v');
  [B_u, B_s] = decompPoly(polyVec, unstableCond);
  bAsteriskVec = fliplr(unstablePoly);
end
function [unstablePoly, stablePoly] =  decompPoly(polyVec, unstableCond)
  rootsVec = roots(polyVec)
  unstableRootsIdx = abs(rootsVec) >= unstableCond;

  unstableRoots = rootsVec(unstableRootsIdx);
  stableRoots = rootsVec(~stableRoots);

  unstablePoly = poly(unstableRoots);
  stablePoly = poly(stableRoots);
end