# brain-eeg-graph
An arduino EEG interface designed to enable lucid dreaming

After seeing the movie [_Inception_](https://www.imdb.com/title/tt1375666/), I was inspired to try and build a [lucid dreaming](https://en.wikipedia.org/wiki/Lucid_dream) device. I decided to take advantage of low cost, commercially available EEG chips which were being incorporated into toys. Using these off-the-shelf devices it is possible to extract low quality EEG signals and perform FFT processing to determine the dominant power spectrum and use that to (indirectly) monitor sleep stage. By detecting the change in EEG pattern from slow wave delta to alpha predominant wakefullness, it is theoretically possible to detect the onset of dreaming. The system plays an audible tone, which (with practice/training) can help the user recognize that they are dreaming, (hopefully) facilitating lucid dreaming.

# system overview


- uses the [brain library](https://github.com/kitschpatrol/Brain) to extract EEG data from a [Force Trainer](https://www.amazon.com/Star-Wars-Science-Force-Trainer/dp/B001UZHASY) or [Mindflex](https://www.amazon.com/Mattel-P2639-Mindflex-Game/dp/B001UEUHCG) EEG module
- streams EEG data over serial connection and displays the results graphically on an attached LCD display
- when the EEG 




# version/to-do
- initial version created 2010 by Nick Mark
- next version intended for realtime EEG analysis to facilitate lucid dreaming

# references
- [Arduino library for reading Neurosky EEG brainwave data](https://github.com/kitschpatrol/Brain)
- [Brain Hack](http://www.frontiernerds.com/brain-hack)
