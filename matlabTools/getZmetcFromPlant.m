function [zmetcCtrl, stepShifter] = getZmetcFromPlant(dstPlt, unstableCond)
  if nargin == 1
    unstableCond = 1;
  end
  T = dstPlt.Ts;
  [den, B_s, ~, bAsteriskVec] = prepare(dstPlt, unstableCond);
  zmetcCtrl = tf(den, B_s, T)*tf(1, bAsteriskVec, T);

  z = tf('z', T);
  relativeDegree = length(pole(dstPlt)) - length(zero(dstPlt));
  stepShifter = z^(-(relativeDegree));
end
