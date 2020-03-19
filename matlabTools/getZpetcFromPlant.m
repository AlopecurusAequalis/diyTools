function [zpetcCtrl, stepShifter] = getZpetcFromPlant(dstPlt, unstableCond)
  if nargin == 1
    unstableCond = 1;
  end
  T = dstPlt.Ts;
  z = tf('z', T);
  [den, B_s, B_u, bAsteriskVec] = prepare(dstPlt, unstableCond);
  B_u0 = sum(B_u);
  zpetcCtrl = tf(den, B_s, T)*tf(bAsteriskVec, B_u0^2, T)*z^(-(length(bAsteriskVec)-1));

  
  relativeDegree = length(pole(dstPlt)) - length(zero(dstPlt));
  unstableZeroCnt = length(B_s);
  stepShifter = z^(-(relativeDegree + unstableZeroCnt));
end
