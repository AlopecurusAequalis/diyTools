function [unstablePoly, stablePoly] =  decompPoly(polyVec, unstableCond)
  rootsVec = roots(polyVec)
  unstableRootsIdx = abs(rootsVec) >= unstableCond;

  unstableRoots = rootsVec(unstableRootsIdx);
  stableRoots = rootsVec(~unstableRootsIdx);

  unstablePoly = poly(unstableRoots);
  stablePoly = poly(stableRoots);
end
