# brain-eeg-graph
An arduino EEG interface designed to enable lucid dreaming

After seeing the movie [_Inception_](https://www.imdb.com/title/tt1375666/), I was inspired to try and build a [lucid dreaming](https://en.wikipedia.org/wiki/Lucid_dream) device. I decided to take advantage of low cost, commercially available EEG chips which were being incorporated into toys. Using these off-the-shelf devices it is possible to extract low quality EEG signals and perform FFT processing to determine the dominant power spectrum and use that to (indirectly) monitor sleep stage. By detecting the change in EEG pattern  it is theoretically possible to detect the onset of dreaming. The system plays an audible tone, which (with practice/training) can help the user recognize that they are dreaming, facilitating lucid dreaming.

# system overview
![system overview](https://github.com/nickmmark/brain-eeg-graph/blob/master/figures/system_overview.png)

* a [Force Trainer](https://www.amazon.com/Star-Wars-Science-Force-Trainer/dp/B001UZHASY) or [Mindflex](https://www.amazon.com/Mattel-P2639-Mindflex-Game/dp/B001UEUHCG) EEG module is connected to an arduino via an [optoisolator](https://en.wikipedia.org/wiki/Opto-isolator).
* The arduino uses the [brain library](https://github.com/kitschpatrol/Brain) to extract EEG data as it listens to the tx/rx pins. 
* the arduino displays the power spectrogram on the attached LCD display
* when the EEG spectrum changes from delta wave predominant (suggesting slow wave sleep) to alpha wave predominant (suggesting either wakefullness or REM) the device emits a tone which can indicate to the user that they are dreaming
* the device also [logs data to an SD card](https://www.adafruit.com/product/1141) for review

# details
![wiring diagram for system](https://github.com/nickmmark/brain-eeg-graph/blob/master/figures/eeg%20wiring%20diagram.png)



# version/to-do
v1.0 - first version intended for realtime EEG analysis and display on LCD
v2.x - subsequent versions adding tone generation and data logging

# references
- [Arduino library for reading Neurosky EEG brainwave data](https://github.com/kitschpatrol/Brain)
- [Brain Hack](http://www.frontiernerds.com/brain-hack)
