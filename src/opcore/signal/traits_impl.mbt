///|
/// # opcore/signal trait 实现 / Signal trait implementations
///
/// 为所有 Point/Series/Matrix/Vector 类型批量实现 Named/Describable/Displayable/Cloneable/Countable trait。

///|
pub impl @traits.Named for AutocorrPoint with name(_self) { "AutocorrPoint" }
pub extend AutocorrPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for AutocorrPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend AutocorrPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for AutocorrPoint with display(self) { "AutocorrPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend AutocorrPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for AutocorrPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend AutocorrPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AutocorrPoint with count(_self) { 2 }
pub extend AutocorrPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for BeamformingPoint with name(_self) { "BeamformingPoint" }
pub extend BeamformingPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for BeamformingPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend BeamformingPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for BeamformingPoint with display(self) { "BeamformingPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend BeamformingPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for BeamformingPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend BeamformingPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for BeamformingPoint with count(_self) { 2 }
pub extend BeamformingPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for CepstralPoint with name(_self) { "CepstralPoint" }
pub extend CepstralPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for CepstralPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend CepstralPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for CepstralPoint with display(self) { "CepstralPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend CepstralPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for CepstralPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend CepstralPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CepstralPoint with count(_self) { 2 }
pub extend CepstralPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Cross_corrPoint with name(_self) { "Cross_corrPoint" }
pub extend Cross_corrPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Cross_corrPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Cross_corrPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cross_corrPoint with display(self) { "Cross_corrPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Cross_corrPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cross_corrPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Cross_corrPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cross_corrPoint with count(_self) { 2 }
pub extend Cross_corrPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_bmPoint with name(_self) { "Denoise_bmPoint" }
pub extend Denoise_bmPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_bmPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Denoise_bmPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_bmPoint with display(self) { "Denoise_bmPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Denoise_bmPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_bmPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Denoise_bmPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_bmPoint with count(_self) { 2 }
pub extend Denoise_bmPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_nlPoint with name(_self) { "Denoise_nlPoint" }
pub extend Denoise_nlPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_nlPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Denoise_nlPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_nlPoint with display(self) { "Denoise_nlPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Denoise_nlPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_nlPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Denoise_nlPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_nlPoint with count(_self) { 2 }
pub extend Denoise_nlPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_waveletPoint with name(_self) { "Denoise_waveletPoint" }
pub extend Denoise_waveletPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_waveletPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Denoise_waveletPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_waveletPoint with display(self) { "Denoise_waveletPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Denoise_waveletPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_waveletPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Denoise_waveletPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_waveletPoint with count(_self) { 2 }
pub extend Denoise_waveletPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for DopplerPoint with name(_self) { "DopplerPoint" }
pub extend DopplerPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for DopplerPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend DopplerPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for DopplerPoint with display(self) { "DopplerPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend DopplerPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for DopplerPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend DopplerPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DopplerPoint with count(_self) { 2 }
pub extend DopplerPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Echo_cancelPoint with name(_self) { "Echo_cancelPoint" }
pub extend Echo_cancelPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Echo_cancelPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Echo_cancelPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Echo_cancelPoint with display(self) { "Echo_cancelPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Echo_cancelPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Echo_cancelPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Echo_cancelPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Echo_cancelPoint with count(_self) { 2 }
pub extend Echo_cancelPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_adaptivePoint with name(_self) { "Filter_adaptivePoint" }
pub extend Filter_adaptivePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_adaptivePoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Filter_adaptivePoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_adaptivePoint with display(self) { "Filter_adaptivePoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Filter_adaptivePoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_adaptivePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Filter_adaptivePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_adaptivePoint with count(_self) { 2 }
pub extend Filter_adaptivePoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_firPoint with name(_self) { "Filter_firPoint" }
pub extend Filter_firPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_firPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Filter_firPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_firPoint with display(self) { "Filter_firPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Filter_firPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_firPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Filter_firPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_firPoint with count(_self) { 2 }
pub extend Filter_firPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_iirPoint with name(_self) { "Filter_iirPoint" }
pub extend Filter_iirPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_iirPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Filter_iirPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_iirPoint with display(self) { "Filter_iirPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Filter_iirPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_iirPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Filter_iirPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_iirPoint with count(_self) { 2 }
pub extend Filter_iirPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Fourier_analysisPoint with name(_self) { "Fourier_analysisPoint" }
pub extend Fourier_analysisPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Fourier_analysisPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Fourier_analysisPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Fourier_analysisPoint with display(self) { "Fourier_analysisPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Fourier_analysisPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Fourier_analysisPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Fourier_analysisPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Fourier_analysisPoint with count(_self) { 2 }
pub extend Fourier_analysisPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for HomomorphicPoint with name(_self) { "HomomorphicPoint" }
pub extend HomomorphicPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for HomomorphicPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend HomomorphicPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for HomomorphicPoint with display(self) { "HomomorphicPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend HomomorphicPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for HomomorphicPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend HomomorphicPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HomomorphicPoint with count(_self) { 2 }
pub extend HomomorphicPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Laplace_transformPoint with name(_self) { "Laplace_transformPoint" }
pub extend Laplace_transformPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Laplace_transformPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Laplace_transformPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Laplace_transformPoint with display(self) { "Laplace_transformPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Laplace_transformPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Laplace_transformPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Laplace_transformPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Laplace_transformPoint with count(_self) { 2 }
pub extend Laplace_transformPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Markov_chainPoint with name(_self) { "Markov_chainPoint" }
pub extend Markov_chainPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Markov_chainPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Markov_chainPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Markov_chainPoint with display(self) { "Markov_chainPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Markov_chainPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Markov_chainPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Markov_chainPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Markov_chainPoint with count(_self) { 2 }
pub extend Markov_chainPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Noise_reducePoint with name(_self) { "Noise_reducePoint" }
pub extend Noise_reducePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Noise_reducePoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Noise_reducePoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Noise_reducePoint with display(self) { "Noise_reducePoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Noise_reducePoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Noise_reducePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Noise_reducePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Noise_reducePoint with count(_self) { 2 }
pub extend Noise_reducePoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Pitch_detectPoint with name(_self) { "Pitch_detectPoint" }
pub extend Pitch_detectPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Pitch_detectPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Pitch_detectPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Pitch_detectPoint with display(self) { "Pitch_detectPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Pitch_detectPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Pitch_detectPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Pitch_detectPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pitch_detectPoint with count(_self) { 2 }
pub extend Pitch_detectPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Queue_theoryPoint with name(_self) { "Queue_theoryPoint" }
pub extend Queue_theoryPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Queue_theoryPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Queue_theoryPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Queue_theoryPoint with display(self) { "Queue_theoryPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Queue_theoryPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Queue_theoryPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Queue_theoryPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Queue_theoryPoint with count(_self) { 2 }
pub extend Queue_theoryPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Seq_analysisPoint with name(_self) { "Seq_analysisPoint" }
pub extend Seq_analysisPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Seq_analysisPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Seq_analysisPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Seq_analysisPoint with display(self) { "Seq_analysisPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Seq_analysisPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Seq_analysisPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Seq_analysisPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Seq_analysisPoint with count(_self) { 2 }
pub extend Seq_analysisPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Series_analysisPoint with name(_self) { "Series_analysisPoint" }
pub extend Series_analysisPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Series_analysisPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Series_analysisPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Series_analysisPoint with display(self) { "Series_analysisPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Series_analysisPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Series_analysisPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Series_analysisPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Series_analysisPoint with count(_self) { 2 }
pub extend Series_analysisPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Spectral_estPoint with name(_self) { "Spectral_estPoint" }
pub extend Spectral_estPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Spectral_estPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Spectral_estPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Spectral_estPoint with display(self) { "Spectral_estPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Spectral_estPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Spectral_estPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Spectral_estPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spectral_estPoint with count(_self) { 2 }
pub extend Spectral_estPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Stochastic_procPoint with name(_self) { "Stochastic_procPoint" }
pub extend Stochastic_procPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Stochastic_procPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Stochastic_procPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stochastic_procPoint with display(self) { "Stochastic_procPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Stochastic_procPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stochastic_procPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Stochastic_procPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stochastic_procPoint with count(_self) { 2 }
pub extend Stochastic_procPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Voice_activityPoint with name(_self) { "Voice_activityPoint" }
pub extend Voice_activityPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Voice_activityPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Voice_activityPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voice_activityPoint with display(self) { "Voice_activityPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Voice_activityPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voice_activityPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Voice_activityPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voice_activityPoint with count(_self) { 2 }
pub extend Voice_activityPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_cwtPoint with name(_self) { "Wavelet_cwtPoint" }
pub extend Wavelet_cwtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_cwtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Wavelet_cwtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_cwtPoint with display(self) { "Wavelet_cwtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Wavelet_cwtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_cwtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Wavelet_cwtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_cwtPoint with count(_self) { 2 }
pub extend Wavelet_cwtPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_dwtPoint with name(_self) { "Wavelet_dwtPoint" }
pub extend Wavelet_dwtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_dwtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Wavelet_dwtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_dwtPoint with display(self) { "Wavelet_dwtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Wavelet_dwtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_dwtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Wavelet_dwtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_dwtPoint with count(_self) { 2 }
pub extend Wavelet_dwtPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for Z_transformPoint with name(_self) { "Z_transformPoint" }
pub extend Z_transformPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Z_transformPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Z_transformPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Z_transformPoint with display(self) { "Z_transformPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Z_transformPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Z_transformPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Z_transformPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Z_transformPoint with count(_self) { 2 }
pub extend Z_transformPoint with @traits.Countable::{count}

///|
pub impl @traits.Named for AutocorrSeries with name(self) { self.name }
pub extend AutocorrSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for AutocorrSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend AutocorrSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for AutocorrSeries with display(self) { "AutocorrSeries[len=" + self.vals.length().to_string() + "]" }
pub extend AutocorrSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for AutocorrSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend AutocorrSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AutocorrSeries with count(self) { self.vals.length() }
pub extend AutocorrSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for BeamformingSeries with name(self) { self.name }
pub extend BeamformingSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for BeamformingSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend BeamformingSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for BeamformingSeries with display(self) { "BeamformingSeries[len=" + self.vals.length().to_string() + "]" }
pub extend BeamformingSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for BeamformingSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend BeamformingSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for BeamformingSeries with count(self) { self.vals.length() }
pub extend BeamformingSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for CepstralSeries with name(self) { self.name }
pub extend CepstralSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for CepstralSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend CepstralSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for CepstralSeries with display(self) { "CepstralSeries[len=" + self.vals.length().to_string() + "]" }
pub extend CepstralSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for CepstralSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend CepstralSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CepstralSeries with count(self) { self.vals.length() }
pub extend CepstralSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Cross_corrSeries with name(self) { self.name }
pub extend Cross_corrSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Cross_corrSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Cross_corrSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cross_corrSeries with display(self) { "Cross_corrSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Cross_corrSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cross_corrSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Cross_corrSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cross_corrSeries with count(self) { self.vals.length() }
pub extend Cross_corrSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_bmSeries with name(self) { self.name }
pub extend Denoise_bmSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_bmSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Denoise_bmSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_bmSeries with display(self) { "Denoise_bmSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Denoise_bmSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_bmSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Denoise_bmSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_bmSeries with count(self) { self.vals.length() }
pub extend Denoise_bmSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_nlSeries with name(self) { self.name }
pub extend Denoise_nlSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_nlSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Denoise_nlSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_nlSeries with display(self) { "Denoise_nlSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Denoise_nlSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_nlSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Denoise_nlSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_nlSeries with count(self) { self.vals.length() }
pub extend Denoise_nlSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_waveletSeries with name(self) { self.name }
pub extend Denoise_waveletSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_waveletSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Denoise_waveletSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_waveletSeries with display(self) { "Denoise_waveletSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Denoise_waveletSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_waveletSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Denoise_waveletSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_waveletSeries with count(self) { self.vals.length() }
pub extend Denoise_waveletSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for DopplerSeries with name(self) { self.name }
pub extend DopplerSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for DopplerSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend DopplerSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for DopplerSeries with display(self) { "DopplerSeries[len=" + self.vals.length().to_string() + "]" }
pub extend DopplerSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for DopplerSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend DopplerSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DopplerSeries with count(self) { self.vals.length() }
pub extend DopplerSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Echo_cancelSeries with name(self) { self.name }
pub extend Echo_cancelSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Echo_cancelSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Echo_cancelSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Echo_cancelSeries with display(self) { "Echo_cancelSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Echo_cancelSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Echo_cancelSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Echo_cancelSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Echo_cancelSeries with count(self) { self.vals.length() }
pub extend Echo_cancelSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_adaptiveSeries with name(self) { self.name }
pub extend Filter_adaptiveSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_adaptiveSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Filter_adaptiveSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_adaptiveSeries with display(self) { "Filter_adaptiveSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Filter_adaptiveSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_adaptiveSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Filter_adaptiveSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_adaptiveSeries with count(self) { self.vals.length() }
pub extend Filter_adaptiveSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_firSeries with name(self) { self.name }
pub extend Filter_firSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_firSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Filter_firSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_firSeries with display(self) { "Filter_firSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Filter_firSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_firSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Filter_firSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_firSeries with count(self) { self.vals.length() }
pub extend Filter_firSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_iirSeries with name(self) { self.name }
pub extend Filter_iirSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_iirSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Filter_iirSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_iirSeries with display(self) { "Filter_iirSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Filter_iirSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_iirSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Filter_iirSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_iirSeries with count(self) { self.vals.length() }
pub extend Filter_iirSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Fourier_analysisSeries with name(self) { self.name }
pub extend Fourier_analysisSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Fourier_analysisSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Fourier_analysisSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Fourier_analysisSeries with display(self) { "Fourier_analysisSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Fourier_analysisSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Fourier_analysisSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Fourier_analysisSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Fourier_analysisSeries with count(self) { self.vals.length() }
pub extend Fourier_analysisSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for HomomorphicSeries with name(self) { self.name }
pub extend HomomorphicSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for HomomorphicSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend HomomorphicSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for HomomorphicSeries with display(self) { "HomomorphicSeries[len=" + self.vals.length().to_string() + "]" }
pub extend HomomorphicSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for HomomorphicSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend HomomorphicSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HomomorphicSeries with count(self) { self.vals.length() }
pub extend HomomorphicSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Laplace_transformSeries with name(self) { self.name }
pub extend Laplace_transformSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Laplace_transformSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Laplace_transformSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Laplace_transformSeries with display(self) { "Laplace_transformSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Laplace_transformSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Laplace_transformSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Laplace_transformSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Laplace_transformSeries with count(self) { self.vals.length() }
pub extend Laplace_transformSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Markov_chainSeries with name(self) { self.name }
pub extend Markov_chainSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Markov_chainSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Markov_chainSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Markov_chainSeries with display(self) { "Markov_chainSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Markov_chainSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Markov_chainSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Markov_chainSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Markov_chainSeries with count(self) { self.vals.length() }
pub extend Markov_chainSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Noise_reduceSeries with name(self) { self.name }
pub extend Noise_reduceSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Noise_reduceSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Noise_reduceSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Noise_reduceSeries with display(self) { "Noise_reduceSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Noise_reduceSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Noise_reduceSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Noise_reduceSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Noise_reduceSeries with count(self) { self.vals.length() }
pub extend Noise_reduceSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Pitch_detectSeries with name(self) { self.name }
pub extend Pitch_detectSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Pitch_detectSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Pitch_detectSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Pitch_detectSeries with display(self) { "Pitch_detectSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Pitch_detectSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Pitch_detectSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Pitch_detectSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pitch_detectSeries with count(self) { self.vals.length() }
pub extend Pitch_detectSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Queue_theorySeries with name(self) { self.name }
pub extend Queue_theorySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Queue_theorySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Queue_theorySeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Queue_theorySeries with display(self) { "Queue_theorySeries[len=" + self.vals.length().to_string() + "]" }
pub extend Queue_theorySeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Queue_theorySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Queue_theorySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Queue_theorySeries with count(self) { self.vals.length() }
pub extend Queue_theorySeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Seq_analysisSeries with name(self) { self.name }
pub extend Seq_analysisSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Seq_analysisSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Seq_analysisSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Seq_analysisSeries with display(self) { "Seq_analysisSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Seq_analysisSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Seq_analysisSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Seq_analysisSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Seq_analysisSeries with count(self) { self.vals.length() }
pub extend Seq_analysisSeries with @traits.Countable::{count}

///|

pub impl @traits.Named for Series_analysisSeries with name(self) { self.name }
pub extend Series_analysisSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Series_analysisSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Series_analysisSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Series_analysisSeries with display(self) { "Series_analysisSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Series_analysisSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Series_analysisSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Series_analysisSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Series_analysisSeries with count(self) { self.vals.length() }
pub extend Series_analysisSeries with @traits.Countable::{count}

///|

pub impl @traits.Named for Spectral_estSeries with name(self) { self.name }
pub extend Spectral_estSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Spectral_estSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Spectral_estSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Spectral_estSeries with display(self) { "Spectral_estSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Spectral_estSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Spectral_estSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Spectral_estSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spectral_estSeries with count(self) { self.vals.length() }
pub extend Spectral_estSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Stochastic_procSeries with name(self) { self.name }
pub extend Stochastic_procSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Stochastic_procSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Stochastic_procSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stochastic_procSeries with display(self) { "Stochastic_procSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Stochastic_procSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stochastic_procSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Stochastic_procSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stochastic_procSeries with count(self) { self.vals.length() }
pub extend Stochastic_procSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Voice_activitySeries with name(self) { self.name }
pub extend Voice_activitySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Voice_activitySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Voice_activitySeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voice_activitySeries with display(self) { "Voice_activitySeries[len=" + self.vals.length().to_string() + "]" }
pub extend Voice_activitySeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voice_activitySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Voice_activitySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voice_activitySeries with count(self) { self.vals.length() }
pub extend Voice_activitySeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_cwtSeries with name(self) { self.name }
pub extend Wavelet_cwtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_cwtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Wavelet_cwtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_cwtSeries with display(self) { "Wavelet_cwtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Wavelet_cwtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_cwtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Wavelet_cwtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_cwtSeries with count(self) { self.vals.length() }
pub extend Wavelet_cwtSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_dwtSeries with name(self) { self.name }
pub extend Wavelet_dwtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_dwtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Wavelet_dwtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_dwtSeries with display(self) { "Wavelet_dwtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Wavelet_dwtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_dwtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Wavelet_dwtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_dwtSeries with count(self) { self.vals.length() }
pub extend Wavelet_dwtSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for Z_transformSeries with name(self) { self.name }
pub extend Z_transformSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Z_transformSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Z_transformSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Z_transformSeries with display(self) { "Z_transformSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Z_transformSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Z_transformSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Z_transformSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Z_transformSeries with count(self) { self.vals.length() }
pub extend Z_transformSeries with @traits.Countable::{count}

///|
pub impl @traits.Named for AutocorrMatrix with name(_self) { "AutocorrMatrix" }
pub extend AutocorrMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for AutocorrMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend AutocorrMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for AutocorrMatrix with display(self) { "AutocorrMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend AutocorrMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for AutocorrMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend AutocorrMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AutocorrMatrix with count(self) { (self.rows * self.cols) }
pub extend AutocorrMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for BeamformingMatrix with name(_self) { "BeamformingMatrix" }
pub extend BeamformingMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for BeamformingMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend BeamformingMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for BeamformingMatrix with display(self) { "BeamformingMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend BeamformingMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for BeamformingMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend BeamformingMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for BeamformingMatrix with count(self) { (self.rows * self.cols) }
pub extend BeamformingMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for CepstralMatrix with name(_self) { "CepstralMatrix" }
pub extend CepstralMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for CepstralMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend CepstralMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for CepstralMatrix with display(self) { "CepstralMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend CepstralMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for CepstralMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend CepstralMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CepstralMatrix with count(self) { (self.rows * self.cols) }
pub extend CepstralMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Cross_corrMatrix with name(_self) { "Cross_corrMatrix" }
pub extend Cross_corrMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Cross_corrMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Cross_corrMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cross_corrMatrix with display(self) { "Cross_corrMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Cross_corrMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cross_corrMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Cross_corrMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cross_corrMatrix with count(self) { (self.rows * self.cols) }
pub extend Cross_corrMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_bmMatrix with name(_self) { "Denoise_bmMatrix" }
pub extend Denoise_bmMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_bmMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Denoise_bmMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_bmMatrix with display(self) { "Denoise_bmMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Denoise_bmMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_bmMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Denoise_bmMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_bmMatrix with count(self) { (self.rows * self.cols) }
pub extend Denoise_bmMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_nlMatrix with name(_self) { "Denoise_nlMatrix" }
pub extend Denoise_nlMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_nlMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Denoise_nlMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_nlMatrix with display(self) { "Denoise_nlMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Denoise_nlMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_nlMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Denoise_nlMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_nlMatrix with count(self) { (self.rows * self.cols) }
pub extend Denoise_nlMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_waveletMatrix with name(_self) { "Denoise_waveletMatrix" }
pub extend Denoise_waveletMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_waveletMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Denoise_waveletMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_waveletMatrix with display(self) { "Denoise_waveletMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Denoise_waveletMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_waveletMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Denoise_waveletMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_waveletMatrix with count(self) { (self.rows * self.cols) }
pub extend Denoise_waveletMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for DopplerMatrix with name(_self) { "DopplerMatrix" }
pub extend DopplerMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for DopplerMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend DopplerMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for DopplerMatrix with display(self) { "DopplerMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend DopplerMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for DopplerMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend DopplerMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DopplerMatrix with count(self) { (self.rows * self.cols) }
pub extend DopplerMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Echo_cancelMatrix with name(_self) { "Echo_cancelMatrix" }
pub extend Echo_cancelMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Echo_cancelMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Echo_cancelMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Echo_cancelMatrix with display(self) { "Echo_cancelMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Echo_cancelMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Echo_cancelMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Echo_cancelMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Echo_cancelMatrix with count(self) { (self.rows * self.cols) }
pub extend Echo_cancelMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_adaptiveMatrix with name(_self) { "Filter_adaptiveMatrix" }
pub extend Filter_adaptiveMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_adaptiveMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Filter_adaptiveMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_adaptiveMatrix with display(self) { "Filter_adaptiveMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Filter_adaptiveMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_adaptiveMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Filter_adaptiveMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_adaptiveMatrix with count(self) { (self.rows * self.cols) }
pub extend Filter_adaptiveMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_firMatrix with name(_self) { "Filter_firMatrix" }
pub extend Filter_firMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_firMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Filter_firMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_firMatrix with display(self) { "Filter_firMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Filter_firMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_firMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Filter_firMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_firMatrix with count(self) { (self.rows * self.cols) }
pub extend Filter_firMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_iirMatrix with name(_self) { "Filter_iirMatrix" }
pub extend Filter_iirMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_iirMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Filter_iirMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_iirMatrix with display(self) { "Filter_iirMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Filter_iirMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_iirMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Filter_iirMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_iirMatrix with count(self) { (self.rows * self.cols) }
pub extend Filter_iirMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Fourier_analysisMatrix with name(_self) { "Fourier_analysisMatrix" }
pub extend Fourier_analysisMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Fourier_analysisMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Fourier_analysisMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Fourier_analysisMatrix with display(self) { "Fourier_analysisMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Fourier_analysisMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Fourier_analysisMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Fourier_analysisMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Fourier_analysisMatrix with count(self) { (self.rows * self.cols) }
pub extend Fourier_analysisMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for HomomorphicMatrix with name(_self) { "HomomorphicMatrix" }
pub extend HomomorphicMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for HomomorphicMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend HomomorphicMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for HomomorphicMatrix with display(self) { "HomomorphicMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend HomomorphicMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for HomomorphicMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend HomomorphicMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HomomorphicMatrix with count(self) { (self.rows * self.cols) }
pub extend HomomorphicMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Laplace_transformMatrix with name(_self) { "Laplace_transformMatrix" }
pub extend Laplace_transformMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Laplace_transformMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Laplace_transformMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Laplace_transformMatrix with display(self) { "Laplace_transformMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Laplace_transformMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Laplace_transformMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Laplace_transformMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Laplace_transformMatrix with count(self) { (self.rows * self.cols) }
pub extend Laplace_transformMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Markov_chainMatrix with name(_self) { "Markov_chainMatrix" }
pub extend Markov_chainMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Markov_chainMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Markov_chainMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Markov_chainMatrix with display(self) { "Markov_chainMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Markov_chainMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Markov_chainMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Markov_chainMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Markov_chainMatrix with count(self) { (self.rows * self.cols) }
pub extend Markov_chainMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Noise_reduceMatrix with name(_self) { "Noise_reduceMatrix" }
pub extend Noise_reduceMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Noise_reduceMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Noise_reduceMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Noise_reduceMatrix with display(self) { "Noise_reduceMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Noise_reduceMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Noise_reduceMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Noise_reduceMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Noise_reduceMatrix with count(self) { (self.rows * self.cols) }
pub extend Noise_reduceMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Pitch_detectMatrix with name(_self) { "Pitch_detectMatrix" }
pub extend Pitch_detectMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Pitch_detectMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Pitch_detectMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Pitch_detectMatrix with display(self) { "Pitch_detectMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Pitch_detectMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Pitch_detectMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Pitch_detectMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pitch_detectMatrix with count(self) { (self.rows * self.cols) }
pub extend Pitch_detectMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Queue_theoryMatrix with name(_self) { "Queue_theoryMatrix" }
pub extend Queue_theoryMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Queue_theoryMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Queue_theoryMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Queue_theoryMatrix with display(self) { "Queue_theoryMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Queue_theoryMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Queue_theoryMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Queue_theoryMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Queue_theoryMatrix with count(self) { (self.rows * self.cols) }
pub extend Queue_theoryMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Seq_analysisMatrix with name(_self) { "Seq_analysisMatrix" }
pub extend Seq_analysisMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Seq_analysisMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Seq_analysisMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Seq_analysisMatrix with display(self) { "Seq_analysisMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Seq_analysisMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Seq_analysisMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Seq_analysisMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Seq_analysisMatrix with count(self) { (self.rows * self.cols) }
pub extend Seq_analysisMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Series_analysisMatrix with name(_self) { "Series_analysisMatrix" }
pub extend Series_analysisMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Series_analysisMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Series_analysisMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Series_analysisMatrix with display(self) { "Series_analysisMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Series_analysisMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Series_analysisMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Series_analysisMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Series_analysisMatrix with count(self) { (self.rows * self.cols) }
pub extend Series_analysisMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Spectral_estMatrix with name(_self) { "Spectral_estMatrix" }
pub extend Spectral_estMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Spectral_estMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Spectral_estMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Spectral_estMatrix with display(self) { "Spectral_estMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Spectral_estMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Spectral_estMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Spectral_estMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spectral_estMatrix with count(self) { (self.rows * self.cols) }
pub extend Spectral_estMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Stochastic_procMatrix with name(_self) { "Stochastic_procMatrix" }
pub extend Stochastic_procMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Stochastic_procMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Stochastic_procMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stochastic_procMatrix with display(self) { "Stochastic_procMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Stochastic_procMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stochastic_procMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Stochastic_procMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stochastic_procMatrix with count(self) { (self.rows * self.cols) }
pub extend Stochastic_procMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Voice_activityMatrix with name(_self) { "Voice_activityMatrix" }
pub extend Voice_activityMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Voice_activityMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Voice_activityMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voice_activityMatrix with display(self) { "Voice_activityMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Voice_activityMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voice_activityMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Voice_activityMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voice_activityMatrix with count(self) { (self.rows * self.cols) }
pub extend Voice_activityMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_cwtMatrix with name(_self) { "Wavelet_cwtMatrix" }
pub extend Wavelet_cwtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_cwtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Wavelet_cwtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_cwtMatrix with display(self) { "Wavelet_cwtMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Wavelet_cwtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_cwtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Wavelet_cwtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_cwtMatrix with count(self) { (self.rows * self.cols) }
pub extend Wavelet_cwtMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_dwtMatrix with name(_self) { "Wavelet_dwtMatrix" }
pub extend Wavelet_dwtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_dwtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Wavelet_dwtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_dwtMatrix with display(self) { "Wavelet_dwtMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Wavelet_dwtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_dwtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Wavelet_dwtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_dwtMatrix with count(self) { (self.rows * self.cols) }
pub extend Wavelet_dwtMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for Z_transformMatrix with name(_self) { "Z_transformMatrix" }
pub extend Z_transformMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Z_transformMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Z_transformMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Z_transformMatrix with display(self) { "Z_transformMatrix[" + self.rows.to_string() + "x" + self.cols.to_string() + "]" }
pub extend Z_transformMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Z_transformMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Z_transformMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Z_transformMatrix with count(self) { (self.rows * self.cols) }
pub extend Z_transformMatrix with @traits.Countable::{count}

///|
pub impl @traits.Named for AutocorrVector with name(_self) { "AutocorrVector" }
pub extend AutocorrVector with @traits.Named::{name}
///|
pub impl @traits.Describable for AutocorrVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend AutocorrVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for AutocorrVector with display(self) { "AutocorrVector[dim=" + self.dim.to_string() + "]" }
pub extend AutocorrVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for AutocorrVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend AutocorrVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AutocorrVector with count(self) { self.comps.length() }
pub extend AutocorrVector with @traits.Countable::{count}

///|
pub impl @traits.Named for BeamformingVector with name(_self) { "BeamformingVector" }
pub extend BeamformingVector with @traits.Named::{name}
///|
pub impl @traits.Describable for BeamformingVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend BeamformingVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for BeamformingVector with display(self) { "BeamformingVector[dim=" + self.dim.to_string() + "]" }
pub extend BeamformingVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for BeamformingVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend BeamformingVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for BeamformingVector with count(self) { self.comps.length() }
pub extend BeamformingVector with @traits.Countable::{count}

///|
pub impl @traits.Named for CepstralVector with name(_self) { "CepstralVector" }
pub extend CepstralVector with @traits.Named::{name}
///|
pub impl @traits.Describable for CepstralVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend CepstralVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for CepstralVector with display(self) { "CepstralVector[dim=" + self.dim.to_string() + "]" }
pub extend CepstralVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for CepstralVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend CepstralVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CepstralVector with count(self) { self.comps.length() }
pub extend CepstralVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Cross_corrVector with name(_self) { "Cross_corrVector" }
pub extend Cross_corrVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Cross_corrVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Cross_corrVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cross_corrVector with display(self) { "Cross_corrVector[dim=" + self.dim.to_string() + "]" }
pub extend Cross_corrVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cross_corrVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Cross_corrVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cross_corrVector with count(self) { self.comps.length() }
pub extend Cross_corrVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_bmVector with name(_self) { "Denoise_bmVector" }
pub extend Denoise_bmVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_bmVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Denoise_bmVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_bmVector with display(self) { "Denoise_bmVector[dim=" + self.dim.to_string() + "]" }
pub extend Denoise_bmVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_bmVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Denoise_bmVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_bmVector with count(self) { self.comps.length() }
pub extend Denoise_bmVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_nlVector with name(_self) { "Denoise_nlVector" }
pub extend Denoise_nlVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_nlVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Denoise_nlVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_nlVector with display(self) { "Denoise_nlVector[dim=" + self.dim.to_string() + "]" }
pub extend Denoise_nlVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_nlVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Denoise_nlVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_nlVector with count(self) { self.comps.length() }
pub extend Denoise_nlVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Denoise_waveletVector with name(_self) { "Denoise_waveletVector" }
pub extend Denoise_waveletVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Denoise_waveletVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Denoise_waveletVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Denoise_waveletVector with display(self) { "Denoise_waveletVector[dim=" + self.dim.to_string() + "]" }
pub extend Denoise_waveletVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Denoise_waveletVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Denoise_waveletVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Denoise_waveletVector with count(self) { self.comps.length() }
pub extend Denoise_waveletVector with @traits.Countable::{count}

///|
pub impl @traits.Named for DopplerVector with name(_self) { "DopplerVector" }
pub extend DopplerVector with @traits.Named::{name}
///|
pub impl @traits.Describable for DopplerVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend DopplerVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for DopplerVector with display(self) { "DopplerVector[dim=" + self.dim.to_string() + "]" }
pub extend DopplerVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for DopplerVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend DopplerVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DopplerVector with count(self) { self.comps.length() }
pub extend DopplerVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Echo_cancelVector with name(_self) { "Echo_cancelVector" }
pub extend Echo_cancelVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Echo_cancelVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Echo_cancelVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Echo_cancelVector with display(self) { "Echo_cancelVector[dim=" + self.dim.to_string() + "]" }
pub extend Echo_cancelVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Echo_cancelVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Echo_cancelVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Echo_cancelVector with count(self) { self.comps.length() }
pub extend Echo_cancelVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_adaptiveVector with name(_self) { "Filter_adaptiveVector" }
pub extend Filter_adaptiveVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_adaptiveVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Filter_adaptiveVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_adaptiveVector with display(self) { "Filter_adaptiveVector[dim=" + self.dim.to_string() + "]" }
pub extend Filter_adaptiveVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_adaptiveVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Filter_adaptiveVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_adaptiveVector with count(self) { self.comps.length() }
pub extend Filter_adaptiveVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_firVector with name(_self) { "Filter_firVector" }
pub extend Filter_firVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_firVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Filter_firVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_firVector with display(self) { "Filter_firVector[dim=" + self.dim.to_string() + "]" }
pub extend Filter_firVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_firVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Filter_firVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_firVector with count(self) { self.comps.length() }
pub extend Filter_firVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Filter_iirVector with name(_self) { "Filter_iirVector" }
pub extend Filter_iirVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Filter_iirVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Filter_iirVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Filter_iirVector with display(self) { "Filter_iirVector[dim=" + self.dim.to_string() + "]" }
pub extend Filter_iirVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Filter_iirVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Filter_iirVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Filter_iirVector with count(self) { self.comps.length() }
pub extend Filter_iirVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Fourier_analysisVector with name(_self) { "Fourier_analysisVector" }
pub extend Fourier_analysisVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Fourier_analysisVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Fourier_analysisVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Fourier_analysisVector with display(self) { "Fourier_analysisVector[dim=" + self.dim.to_string() + "]" }
pub extend Fourier_analysisVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Fourier_analysisVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Fourier_analysisVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Fourier_analysisVector with count(self) { self.comps.length() }
pub extend Fourier_analysisVector with @traits.Countable::{count}

///|
pub impl @traits.Named for HomomorphicVector with name(_self) { "HomomorphicVector" }
pub extend HomomorphicVector with @traits.Named::{name}
///|
pub impl @traits.Describable for HomomorphicVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend HomomorphicVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for HomomorphicVector with display(self) { "HomomorphicVector[dim=" + self.dim.to_string() + "]" }
pub extend HomomorphicVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for HomomorphicVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend HomomorphicVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HomomorphicVector with count(self) { self.comps.length() }
pub extend HomomorphicVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Laplace_transformVector with name(_self) { "Laplace_transformVector" }
pub extend Laplace_transformVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Laplace_transformVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Laplace_transformVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Laplace_transformVector with display(self) { "Laplace_transformVector[dim=" + self.dim.to_string() + "]" }
pub extend Laplace_transformVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Laplace_transformVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Laplace_transformVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Laplace_transformVector with count(self) { self.comps.length() }
pub extend Laplace_transformVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Markov_chainVector with name(_self) { "Markov_chainVector" }
pub extend Markov_chainVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Markov_chainVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Markov_chainVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Markov_chainVector with display(self) { "Markov_chainVector[dim=" + self.dim.to_string() + "]" }
pub extend Markov_chainVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Markov_chainVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Markov_chainVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Markov_chainVector with count(self) { self.comps.length() }
pub extend Markov_chainVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Noise_reduceVector with name(_self) { "Noise_reduceVector" }
pub extend Noise_reduceVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Noise_reduceVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Noise_reduceVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Noise_reduceVector with display(self) { "Noise_reduceVector[dim=" + self.dim.to_string() + "]" }
pub extend Noise_reduceVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Noise_reduceVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Noise_reduceVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Noise_reduceVector with count(self) { self.comps.length() }
pub extend Noise_reduceVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Pitch_detectVector with name(_self) { "Pitch_detectVector" }
pub extend Pitch_detectVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Pitch_detectVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Pitch_detectVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Pitch_detectVector with display(self) { "Pitch_detectVector[dim=" + self.dim.to_string() + "]" }
pub extend Pitch_detectVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Pitch_detectVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Pitch_detectVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pitch_detectVector with count(self) { self.comps.length() }
pub extend Pitch_detectVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Queue_theoryVector with name(_self) { "Queue_theoryVector" }
pub extend Queue_theoryVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Queue_theoryVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Queue_theoryVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Queue_theoryVector with display(self) { "Queue_theoryVector[dim=" + self.dim.to_string() + "]" }
pub extend Queue_theoryVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Queue_theoryVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Queue_theoryVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Queue_theoryVector with count(self) { self.comps.length() }
pub extend Queue_theoryVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Seq_analysisVector with name(_self) { "Seq_analysisVector" }
pub extend Seq_analysisVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Seq_analysisVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Seq_analysisVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Seq_analysisVector with display(self) { "Seq_analysisVector[dim=" + self.dim.to_string() + "]" }
pub extend Seq_analysisVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Seq_analysisVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Seq_analysisVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Seq_analysisVector with count(self) { self.comps.length() }
pub extend Seq_analysisVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Series_analysisVector with name(_self) { "Series_analysisVector" }
pub extend Series_analysisVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Series_analysisVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Series_analysisVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Series_analysisVector with display(self) { "Series_analysisVector[dim=" + self.dim.to_string() + "]" }
pub extend Series_analysisVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Series_analysisVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Series_analysisVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Series_analysisVector with count(self) { self.comps.length() }
pub extend Series_analysisVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Spectral_estVector with name(_self) { "Spectral_estVector" }
pub extend Spectral_estVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Spectral_estVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Spectral_estVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Spectral_estVector with display(self) { "Spectral_estVector[dim=" + self.dim.to_string() + "]" }
pub extend Spectral_estVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Spectral_estVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Spectral_estVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spectral_estVector with count(self) { self.comps.length() }
pub extend Spectral_estVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Stochastic_procVector with name(_self) { "Stochastic_procVector" }
pub extend Stochastic_procVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Stochastic_procVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Stochastic_procVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stochastic_procVector with display(self) { "Stochastic_procVector[dim=" + self.dim.to_string() + "]" }
pub extend Stochastic_procVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stochastic_procVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Stochastic_procVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stochastic_procVector with count(self) { self.comps.length() }
pub extend Stochastic_procVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Voice_activityVector with name(_self) { "Voice_activityVector" }
pub extend Voice_activityVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Voice_activityVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Voice_activityVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voice_activityVector with display(self) { "Voice_activityVector[dim=" + self.dim.to_string() + "]" }
pub extend Voice_activityVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voice_activityVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Voice_activityVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voice_activityVector with count(self) { self.comps.length() }
pub extend Voice_activityVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_cwtVector with name(_self) { "Wavelet_cwtVector" }
pub extend Wavelet_cwtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_cwtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Wavelet_cwtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_cwtVector with display(self) { "Wavelet_cwtVector[dim=" + self.dim.to_string() + "]" }
pub extend Wavelet_cwtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_cwtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Wavelet_cwtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_cwtVector with count(self) { self.comps.length() }
pub extend Wavelet_cwtVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Wavelet_dwtVector with name(_self) { "Wavelet_dwtVector" }
pub extend Wavelet_dwtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Wavelet_dwtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Wavelet_dwtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Wavelet_dwtVector with display(self) { "Wavelet_dwtVector[dim=" + self.dim.to_string() + "]" }
pub extend Wavelet_dwtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Wavelet_dwtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Wavelet_dwtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wavelet_dwtVector with count(self) { self.comps.length() }
pub extend Wavelet_dwtVector with @traits.Countable::{count}

///|
pub impl @traits.Named for Z_transformVector with name(_self) { "Z_transformVector" }
pub extend Z_transformVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Z_transformVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Z_transformVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Z_transformVector with display(self) { "Z_transformVector[dim=" + self.dim.to_string() + "]" }
pub extend Z_transformVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Z_transformVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Z_transformVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Z_transformVector with count(self) { self.comps.length() }
pub extend Z_transformVector with @traits.Countable::{count}





///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for AutocorrMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend AutocorrMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AutocorrMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend AutocorrMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AutocorrPoint with check(_self) { true }
pub extend AutocorrPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AutocorrPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend AutocorrPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AutocorrSeries with check(self) { self.vals.length() > 0 }
pub extend AutocorrSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AutocorrSeries with reset(_self) { { vals: [], name: "", } }
pub extend AutocorrSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AutocorrVector with check(self) { self.dim > 0 }
pub extend AutocorrVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AutocorrVector with reset(_self) { { comps: [], dim: 0, } }
pub extend AutocorrVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for BeamformingMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend BeamformingMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for BeamformingMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend BeamformingMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for BeamformingPoint with check(_self) { true }
pub extend BeamformingPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for BeamformingPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend BeamformingPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for BeamformingSeries with check(self) { self.vals.length() > 0 }
pub extend BeamformingSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for BeamformingSeries with reset(_self) { { vals: [], name: "", } }
pub extend BeamformingSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for BeamformingVector with check(self) { self.dim > 0 }
pub extend BeamformingVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for BeamformingVector with reset(_self) { { comps: [], dim: 0, } }
pub extend BeamformingVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CepstralMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend CepstralMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CepstralMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend CepstralMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CepstralPoint with check(_self) { true }
pub extend CepstralPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CepstralPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend CepstralPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CepstralSeries with check(self) { self.vals.length() > 0 }
pub extend CepstralSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CepstralSeries with reset(_self) { { vals: [], name: "", } }
pub extend CepstralSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CepstralVector with check(self) { self.dim > 0 }
pub extend CepstralVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CepstralVector with reset(_self) { { comps: [], dim: 0, } }
pub extend CepstralVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cross_corrMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Cross_corrMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cross_corrMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Cross_corrMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cross_corrPoint with check(_self) { true }
pub extend Cross_corrPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cross_corrPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Cross_corrPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cross_corrSeries with check(self) { self.vals.length() > 0 }
pub extend Cross_corrSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cross_corrSeries with reset(_self) { { vals: [], name: "", } }
pub extend Cross_corrSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cross_corrVector with check(self) { self.dim > 0 }
pub extend Cross_corrVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cross_corrVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Cross_corrVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_bmMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Denoise_bmMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_bmMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Denoise_bmMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_bmPoint with check(_self) { true }
pub extend Denoise_bmPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_bmPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Denoise_bmPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_bmSeries with check(self) { self.vals.length() > 0 }
pub extend Denoise_bmSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_bmSeries with reset(_self) { { vals: [], name: "", } }
pub extend Denoise_bmSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_bmVector with check(self) { self.dim > 0 }
pub extend Denoise_bmVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_bmVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Denoise_bmVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_nlMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Denoise_nlMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_nlMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Denoise_nlMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_nlPoint with check(_self) { true }
pub extend Denoise_nlPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_nlPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Denoise_nlPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_nlSeries with check(self) { self.vals.length() > 0 }
pub extend Denoise_nlSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_nlSeries with reset(_self) { { vals: [], name: "", } }
pub extend Denoise_nlSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_nlVector with check(self) { self.dim > 0 }
pub extend Denoise_nlVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_nlVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Denoise_nlVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_waveletMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Denoise_waveletMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_waveletMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Denoise_waveletMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_waveletPoint with check(_self) { true }
pub extend Denoise_waveletPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_waveletPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Denoise_waveletPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_waveletSeries with check(self) { self.vals.length() > 0 }
pub extend Denoise_waveletSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_waveletSeries with reset(_self) { { vals: [], name: "", } }
pub extend Denoise_waveletSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Denoise_waveletVector with check(self) { self.dim > 0 }
pub extend Denoise_waveletVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Denoise_waveletVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Denoise_waveletVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DopplerMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend DopplerMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DopplerMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend DopplerMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DopplerPoint with check(_self) { true }
pub extend DopplerPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DopplerPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend DopplerPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DopplerSeries with check(self) { self.vals.length() > 0 }
pub extend DopplerSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DopplerSeries with reset(_self) { { vals: [], name: "", } }
pub extend DopplerSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DopplerVector with check(self) { self.dim > 0 }
pub extend DopplerVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DopplerVector with reset(_self) { { comps: [], dim: 0, } }
pub extend DopplerVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Echo_cancelMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Echo_cancelMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Echo_cancelMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Echo_cancelMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Echo_cancelPoint with check(_self) { true }
pub extend Echo_cancelPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Echo_cancelPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Echo_cancelPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Echo_cancelSeries with check(self) { self.vals.length() > 0 }
pub extend Echo_cancelSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Echo_cancelSeries with reset(_self) { { vals: [], name: "", } }
pub extend Echo_cancelSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Echo_cancelVector with check(self) { self.dim > 0 }
pub extend Echo_cancelVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Echo_cancelVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Echo_cancelVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_adaptiveMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Filter_adaptiveMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_adaptiveMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Filter_adaptiveMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_adaptivePoint with check(_self) { true }
pub extend Filter_adaptivePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_adaptivePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Filter_adaptivePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_adaptiveSeries with check(self) { self.vals.length() > 0 }
pub extend Filter_adaptiveSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_adaptiveSeries with reset(_self) { { vals: [], name: "", } }
pub extend Filter_adaptiveSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_adaptiveVector with check(self) { self.dim > 0 }
pub extend Filter_adaptiveVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_adaptiveVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Filter_adaptiveVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_firMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Filter_firMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_firMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Filter_firMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_firPoint with check(_self) { true }
pub extend Filter_firPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_firPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Filter_firPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_firSeries with check(self) { self.vals.length() > 0 }
pub extend Filter_firSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_firSeries with reset(_self) { { vals: [], name: "", } }
pub extend Filter_firSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_firVector with check(self) { self.dim > 0 }
pub extend Filter_firVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_firVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Filter_firVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_iirMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Filter_iirMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_iirMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Filter_iirMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_iirPoint with check(_self) { true }
pub extend Filter_iirPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_iirPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Filter_iirPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_iirSeries with check(self) { self.vals.length() > 0 }
pub extend Filter_iirSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_iirSeries with reset(_self) { { vals: [], name: "", } }
pub extend Filter_iirSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Filter_iirVector with check(self) { self.dim > 0 }
pub extend Filter_iirVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Filter_iirVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Filter_iirVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Fourier_analysisMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Fourier_analysisMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Fourier_analysisMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Fourier_analysisMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Fourier_analysisPoint with check(_self) { true }
pub extend Fourier_analysisPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Fourier_analysisPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Fourier_analysisPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Fourier_analysisSeries with check(self) { self.vals.length() > 0 }
pub extend Fourier_analysisSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Fourier_analysisSeries with reset(_self) { { vals: [], name: "", } }
pub extend Fourier_analysisSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Fourier_analysisVector with check(self) { self.dim > 0 }
pub extend Fourier_analysisVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Fourier_analysisVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Fourier_analysisVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HomomorphicMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend HomomorphicMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HomomorphicMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend HomomorphicMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HomomorphicPoint with check(_self) { true }
pub extend HomomorphicPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HomomorphicPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend HomomorphicPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HomomorphicSeries with check(self) { self.vals.length() > 0 }
pub extend HomomorphicSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HomomorphicSeries with reset(_self) { { vals: [], name: "", } }
pub extend HomomorphicSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HomomorphicVector with check(self) { self.dim > 0 }
pub extend HomomorphicVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HomomorphicVector with reset(_self) { { comps: [], dim: 0, } }
pub extend HomomorphicVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Laplace_transformMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Laplace_transformMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Laplace_transformMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Laplace_transformMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Laplace_transformPoint with check(_self) { true }
pub extend Laplace_transformPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Laplace_transformPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Laplace_transformPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Laplace_transformSeries with check(self) { self.vals.length() > 0 }
pub extend Laplace_transformSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Laplace_transformSeries with reset(_self) { { vals: [], name: "", } }
pub extend Laplace_transformSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Laplace_transformVector with check(self) { self.dim > 0 }
pub extend Laplace_transformVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Laplace_transformVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Laplace_transformVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Markov_chainMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Markov_chainMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Markov_chainMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Markov_chainMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Markov_chainPoint with check(_self) { true }
pub extend Markov_chainPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Markov_chainPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Markov_chainPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Markov_chainSeries with check(self) { self.vals.length() > 0 }
pub extend Markov_chainSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Markov_chainSeries with reset(_self) { { vals: [], name: "", } }
pub extend Markov_chainSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Markov_chainVector with check(self) { self.dim > 0 }
pub extend Markov_chainVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Markov_chainVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Markov_chainVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Noise_reduceMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Noise_reduceMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Noise_reduceMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Noise_reduceMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Noise_reducePoint with check(_self) { true }
pub extend Noise_reducePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Noise_reducePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Noise_reducePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Noise_reduceSeries with check(self) { self.vals.length() > 0 }
pub extend Noise_reduceSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Noise_reduceSeries with reset(_self) { { vals: [], name: "", } }
pub extend Noise_reduceSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Noise_reduceVector with check(self) { self.dim > 0 }
pub extend Noise_reduceVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Noise_reduceVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Noise_reduceVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pitch_detectMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Pitch_detectMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pitch_detectMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Pitch_detectMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pitch_detectPoint with check(_self) { true }
pub extend Pitch_detectPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pitch_detectPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Pitch_detectPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pitch_detectSeries with check(self) { self.vals.length() > 0 }
pub extend Pitch_detectSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pitch_detectSeries with reset(_self) { { vals: [], name: "", } }
pub extend Pitch_detectSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pitch_detectVector with check(self) { self.dim > 0 }
pub extend Pitch_detectVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pitch_detectVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Pitch_detectVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Queue_theoryMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Queue_theoryMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Queue_theoryMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Queue_theoryMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Queue_theoryPoint with check(_self) { true }
pub extend Queue_theoryPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Queue_theoryPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Queue_theoryPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Queue_theorySeries with check(self) { self.vals.length() > 0 }
pub extend Queue_theorySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Queue_theorySeries with reset(_self) { { vals: [], name: "", } }
pub extend Queue_theorySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Queue_theoryVector with check(self) { self.dim > 0 }
pub extend Queue_theoryVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Queue_theoryVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Queue_theoryVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Seq_analysisMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Seq_analysisMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Seq_analysisMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Seq_analysisMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Seq_analysisPoint with check(_self) { true }
pub extend Seq_analysisPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Seq_analysisPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Seq_analysisPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Seq_analysisSeries with check(self) { self.vals.length() > 0 }
pub extend Seq_analysisSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Seq_analysisSeries with reset(_self) { { vals: [], name: "", } }
pub extend Seq_analysisSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Seq_analysisVector with check(self) { self.dim > 0 }
pub extend Seq_analysisVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Seq_analysisVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Seq_analysisVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Series_analysisMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Series_analysisMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Series_analysisMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Series_analysisMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Series_analysisPoint with check(_self) { true }
pub extend Series_analysisPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Series_analysisPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Series_analysisPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Series_analysisSeries with check(self) { self.vals.length() > 0 }
pub extend Series_analysisSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Series_analysisSeries with reset(_self) { { vals: [], name: "", } }
pub extend Series_analysisSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Series_analysisVector with check(self) { self.dim > 0 }
pub extend Series_analysisVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Series_analysisVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Series_analysisVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spectral_estMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Spectral_estMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spectral_estMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Spectral_estMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spectral_estPoint with check(_self) { true }
pub extend Spectral_estPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spectral_estPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Spectral_estPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spectral_estSeries with check(self) { self.vals.length() > 0 }
pub extend Spectral_estSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spectral_estSeries with reset(_self) { { vals: [], name: "", } }
pub extend Spectral_estSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spectral_estVector with check(self) { self.dim > 0 }
pub extend Spectral_estVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spectral_estVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Spectral_estVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stochastic_procMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Stochastic_procMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stochastic_procMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Stochastic_procMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stochastic_procPoint with check(_self) { true }
pub extend Stochastic_procPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stochastic_procPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Stochastic_procPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stochastic_procSeries with check(self) { self.vals.length() > 0 }
pub extend Stochastic_procSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stochastic_procSeries with reset(_self) { { vals: [], name: "", } }
pub extend Stochastic_procSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stochastic_procVector with check(self) { self.dim > 0 }
pub extend Stochastic_procVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stochastic_procVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Stochastic_procVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voice_activityMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Voice_activityMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voice_activityMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Voice_activityMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voice_activityPoint with check(_self) { true }
pub extend Voice_activityPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voice_activityPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Voice_activityPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voice_activitySeries with check(self) { self.vals.length() > 0 }
pub extend Voice_activitySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voice_activitySeries with reset(_self) { { vals: [], name: "", } }
pub extend Voice_activitySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voice_activityVector with check(self) { self.dim > 0 }
pub extend Voice_activityVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voice_activityVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Voice_activityVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_cwtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Wavelet_cwtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_cwtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Wavelet_cwtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_cwtPoint with check(_self) { true }
pub extend Wavelet_cwtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_cwtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Wavelet_cwtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_cwtSeries with check(self) { self.vals.length() > 0 }
pub extend Wavelet_cwtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_cwtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Wavelet_cwtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_cwtVector with check(self) { self.dim > 0 }
pub extend Wavelet_cwtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_cwtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Wavelet_cwtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_dwtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Wavelet_dwtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_dwtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Wavelet_dwtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_dwtPoint with check(_self) { true }
pub extend Wavelet_dwtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_dwtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Wavelet_dwtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_dwtSeries with check(self) { self.vals.length() > 0 }
pub extend Wavelet_dwtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_dwtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Wavelet_dwtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wavelet_dwtVector with check(self) { self.dim > 0 }
pub extend Wavelet_dwtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wavelet_dwtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Wavelet_dwtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Z_transformMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Z_transformMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Z_transformMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Z_transformMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Z_transformPoint with check(_self) { true }
pub extend Z_transformPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Z_transformPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Z_transformPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Z_transformSeries with check(self) { self.vals.length() > 0 }
pub extend Z_transformSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Z_transformSeries with reset(_self) { { vals: [], name: "", } }
pub extend Z_transformSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Z_transformVector with check(self) { self.dim > 0 }
pub extend Z_transformVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Z_transformVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Z_transformVector with @traits.Resettable::{reset}
