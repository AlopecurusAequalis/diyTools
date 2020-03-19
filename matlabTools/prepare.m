function [A, B_s, B_u, bAsteriskVec] = prepare(dstPlt, unstableCond)
  [B, A] = tfdata(dstPlt, 'v');
  [B_u, B_s] = decompPoly(B, unstableCond);
  bAsteriskVec = fliplr(B_u);
end
