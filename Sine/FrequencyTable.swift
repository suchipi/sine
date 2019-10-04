import Foundation

private let frequenciesByNoteName = [
    "C0": 16.35,
    "C#0": 17.32,
    "Db0": 17.32,
    "D0": 18.35,
    "D#0": 19.45,
    "Eb0": 19.45,
    "E0": 20.60,
    "F0": 21.83,
    "F#0": 23.12,
    "Gb0": 23.12,
    "G0": 24.50,
    "G#0": 25.96,
    "Ab0": 25.96,
    "A0": 27.50,
    "A#0": 29.14,
    "Bb0": 29.14,
    "B0": 30.87,
    "C1": 32.70,
    "C#1": 34.65,
    "Db1": 34.65,
    "D1": 36.71,
    "D#1": 38.89,
    "Eb1": 38.89,
    "E1": 41.20,
    "F1": 43.65,
    "F#1": 46.25,
    "Gb1": 46.25,
    "G1": 49.00,
    "G#1": 51.91,
    "Ab1": 51.91,
    "A1": 55.00,
    "A#1": 58.27,
    "Bb1": 58.27,
    "B1": 61.74,
    "C2": 65.41,
    "C#2": 69.30,
    "Db2": 69.30,
    "D2": 73.42,
    "D#2": 77.78,
    "Eb2": 77.78,
    "E2": 82.41,
    "F2": 87.31,
    "F#2": 92.50,
    "Gb2": 92.50,
    "G2": 98.00,
    "G#2": 103.83,
    "Ab2": 103.83,
    "A2": 110.00,
    "A#2": 116.54,
    "Bb2": 116.54,
    "B2": 123.47,
    "C3": 130.81,
    "C#3": 138.59,
    "Db3": 138.59,
    "D3": 146.83,
    "D#3": 155.56,
    "Eb3": 155.56,
    "E3": 164.81,
    "F3": 174.61,
    "F#3": 185.00,
    "Gb3": 185.00,
    "G3": 196.00,
    "G#3": 207.65,
    "Ab3": 207.65,
    "A3": 220.00,
    "A#3": 233.08,
    "Bb3": 233.08,
    "B3": 246.94,
    "C4": 261.63,
    "C#4": 277.18,
    "Db4": 277.18,
    "D4": 293.66,
    "D#4": 311.13,
    "Eb4": 311.13,
    "E4": 329.63,
    "F4": 349.23,
    "F#4": 369.99,
    "Gb4": 369.99,
    "G4": 392.00,
    "G#4": 415.30,
    "Ab4": 415.30,
    "A4": 440.00,
    "A#4": 466.16,
    "Bb4": 466.16,
    "B4": 493.88,
    "C5": 523.25,
    "C#5": 554.37,
    "Db5": 554.37,
    "D5": 587.33,
    "D#5": 622.25,
    "Eb5": 622.25,
    "E5": 659.25,
    "F5": 698.46,
    "F#5": 739.99,
    "Gb5": 739.99,
    "G5": 783.99,
    "G#5": 830.61,
    "Ab5": 830.61,
    "A5": 880.00,
    "A#5": 932.33,
    "Bb5": 932.33,
    "B5": 987.77,
    "C6": 1046.50,
    "C#6": 1108.73,
    "Db6": 1108.73,
    "D6": 1174.66,
    "D#6": 1244.51,
    "Eb6": 1244.51,
    "E6": 1318.51,
    "F6": 1396.91,
    "F#6": 1479.98,
    "Gb6": 1479.98,
    "G6": 1567.98,
    "G#6": 1661.22,
    "Ab6": 1661.22,
    "A6": 1760.00,
    "A#6": 1864.66,
    "Bb6": 1864.66,
    "B6": 1975.53,
    "C7": 2093.00,
    "C#7": 2217.46,
    "Db7": 2217.46,
    "D7": 2349.32,
    "D#7": 2489.02,
    "Eb7": 2489.02,
    "E7": 2637.02,
    "F7": 2793.83,
    "F#7": 2959.96,
    "Gb7": 2959.96,
    "G7": 3135.96,
    "G#7": 3322.44,
    "Ab7": 3322.44,
    "A7": 3520.00,
    "A#7": 3729.31,
    "Bb7": 3729.31,
    "B7": 3951.07,
    "C8": 4186.01,
    "C#8": 4434.92,
    "Db8": 4434.92,
    "D8": 4698.63,
    "D#8": 4978.03,
    "Eb8": 4978.03,
    "E8": 5274.04,
    "F8": 5587.65,
    "F#8": 5919.91,
    "Gb8": 5919.91,
    "G8": 6271.93,
    "G#8": 6644.88,
    "Ab8": 6644.88,
    "A8": 7040.00,
    "A#8": 7458.62,
    "Bb8": 7458.62,
    "B8": 7902.13,
]

private func halfway(_ lowerName: String, _ upperName: String) -> Double {
    let lowerBound = frequenciesByNoteName[lowerName]
    let upperBound = frequenciesByNoteName[upperName]
    return (lowerBound! + upperBound!) / 2
}

private func near(_ lowerName: String, _ midName: String, _ upperName: String) -> Range<Double> {
    let lower = halfway(lowerName, midName)
    let upper = halfway(midName, upperName)
    
    return Range<Double>(uncheckedBounds: (lower, upper))
}
    
class FrequencyTable {
    static func getFrequency(_ noteName: String) -> Double {
        return frequenciesByNoteName[noteName] ?? 0.0;
    };
    
    static func getNoteName(frequency: Double) -> String? {
        var noteName: String?
        switch frequency {
        case 0..<halfway("C0", "C#0"):
            noteName = "C0"
        case near("C0", "C#0", "D0"):
            noteName = "C#0/Db0"
        case near("C#0", "D0", "D#0"):
            noteName = "D0"
        case near("D0", "D#0", "E0"):
            noteName = "D#0/Eb0"
        case near("D#0", "E0", "F0"):
            noteName = "E0"
        case near("E0", "F0", "F#0"):
            noteName = "F0"
        case near("F0", "F#0", "G0"):
            noteName = "F#0/Gb0"
        case near("F#0", "G0", "G#0"):
            noteName = "G0"
        case near("G0", "G#0", "A0"):
            noteName = "G#0/Ab0"
        case near("G#0", "A0", "A#0"):
            noteName = "A0"
        case near("A0", "A#0", "B0"):
            noteName = "A#0/Bb0"
        case near("A#0", "B0", "C1"):
            noteName = "B0"
        case near("B0", "C1", "C#1"):
            noteName = "C1"
        case near("C1", "C#1", "D1"):
            noteName = "C#1/Db1"
        case near("C#1", "D1", "D#1"):
            noteName = "D1"
        case near("D1", "D#1", "E1"):
            noteName = "D#1/Eb1"
        case near("D#1", "E1", "F1"):
            noteName = "E1"
        case near("E1", "F1", "F#1"):
            noteName = "F1"
        case near("F1", "F#1", "G1"):
            noteName = "F#1/Gb1"
        case near("F#1", "G1", "G#1"):
            noteName = "G1"
        case near("G1", "G#1", "A1"):
            noteName = "G#1/Ab1"
        case near("G#1", "A1", "A#1"):
            noteName = "A1"
        case near("A1", "A#1", "B1"):
            noteName = "A#1/Bb1"
        case near("A#1", "B1", "C2"):
            noteName = "B1"
        case near("B1", "C2", "C#2"):
            noteName = "C2"
        case near("C2", "C#2", "D2"):
            noteName = "C#2/Db2"
        case near("C#2", "D2", "D#2"):
            noteName = "D2"
        case near("D2", "D#2", "E2"):
            noteName = "D#2/Eb2"
        case near("D#2", "E2", "F2"):
            noteName = "E2"
        case near("E2", "F2", "F#2"):
            noteName = "F2"
        case near("F2", "F#2", "G2"):
            noteName = "F#2/Gb2"
        case near("F#2", "G2", "G#2"):
            noteName = "G2"
        case near("G2", "G#2", "A2"):
            noteName = "G#2/Ab2"
        case near("G#2", "A2", "A#2"):
            noteName = "A2"
        case near("A2", "A#2", "B2"):
            noteName = "A#2/Bb2"
        case near("A#2", "B2", "C3"):
            noteName = "B2"
        case near("B2", "C3", "C#3"):
            noteName = "C3"
        case near("C3", "C#3", "D3"):
            noteName = "C#3/Db3"
        case near("C#3", "D3", "D#3"):
            noteName = "D3"
        case near("D3", "D#3", "E3"):
            noteName = "D#3/Eb3"
        case near("D#3", "E3", "F3"):
            noteName = "E3"
        case near("E3", "F3", "F#3"):
            noteName = "F3"
        case near("F3", "F#3", "G3"):
            noteName = "F#3/Gb3"
        case near("F#3", "G3", "G#3"):
            noteName = "G3"
        case near("G3", "G#3", "A3"):
            noteName = "G#3/Ab3"
        case near("G#3", "A3", "A#3"):
            noteName = "A3"
        case near("A3", "A#3", "B3"):
            noteName = "A#3/Bb3"
        case near("A#3", "B3", "C4"):
            noteName = "B3"
        case near("B3", "C4", "C#4"):
            noteName = "C4"
        case near("C4", "C#4", "D4"):
            noteName = "C#4/Db4"
        case near("C#4", "D4", "D#4"):
            noteName = "D4"
        case near("D4", "D#4", "E4"):
            noteName = "D#4/Eb4"
        case near("D#4", "E4", "F4"):
            noteName = "E4"
        case near("E4", "F4", "F#4"):
            noteName = "F4"
        case near("F4", "F#4", "G4"):
            noteName = "F#4/Gb4"
        case near("F#4", "G4", "G#4"):
            noteName = "G4"
        case near("G4", "G#4", "A4"):
            noteName = "G#4/Ab4"
        case near("G#4", "A4", "A#4"):
            noteName = "A4"
        case near("A4", "A#4", "B4"):
            noteName = "A#4/Bb4"
        case near("A#4", "B4", "C5"):
            noteName = "B4"
        case near("B4", "C5", "C#5"):
            noteName = "C5"
        case near("C5", "C#5", "D5"):
            noteName = "C#5/Db5"
        case near("C#5", "D5", "D#5"):
            noteName = "D5"
        case near("D5", "D#5", "E5"):
            noteName = "D#5/Eb5"
        case near("D#5", "E5", "F5"):
            noteName = "E5"
        case near("E5", "F5", "F#5"):
            noteName = "F5"
        case near("F5", "F#5", "G5"):
            noteName = "F#5/Gb5"
        case near("F#5", "G5", "G#5"):
            noteName = "G5"
        case near("G5", "G#5", "A5"):
            noteName = "G#5/Ab5"
        case near("G#5", "A5", "A#5"):
            noteName = "A5"
        case near("A5", "A#5", "B5"):
            noteName = "A#5/Bb5"
        case near("A#5", "B5", "C6"):
            noteName = "B5"
        case near("B5", "C6", "C#6"):
            noteName = "C6"
        case near("C6", "C#6", "D6"):
            noteName = "C#6/Db6"
        case near("C#6", "D6", "D#6"):
            noteName = "D6"
        case near("D6", "D#6", "E6"):
            noteName = "D#6/Eb6"
        case near("D#6", "E6", "F6"):
            noteName = "E6"
        case near("E6", "F6", "F#6"):
            noteName = "F6"
        case near("F6", "F#6", "G6"):
            noteName = "F#6/Gb6"
        case near("F#6", "G6", "G#6"):
            noteName = "G6"
        case near("G6", "G#6", "A6"):
            noteName = "G#6/Ab6"
        case near("G#6", "A6", "A#6"):
            noteName = "A6"
        case near("A6", "A#6", "B6"):
            noteName = "A#6/Bb6"
        case near("A#6", "B6", "C7"):
            noteName = "B6"
        case near("B6", "C7", "C#7"):
            noteName = "C7"
        case near("C7", "C#7", "D7"):
            noteName = "C#7/Db7"
        case near("C#7", "D7", "D#7"):
            noteName = "D7"
        case near("D7", "D#7", "E7"):
            noteName = "D#7/Eb7"
        case near("D#7", "E7", "F7"):
            noteName = "E7"
        case near("E7", "F7", "F#7"):
            noteName = "F7"
        case near("F7", "F#7", "G7"):
            noteName = "F#7/Gb7"
        case near("F#7", "G7", "G#7"):
            noteName = "G7"
        case near("G7", "G#7", "A7"):
            noteName = "G#7/Ab7"
        case near("G#7", "A7", "A#7"):
            noteName = "A7"
        case near("A7", "A#7", "B7"):
            noteName = "A#7/Bb7"
        case near("A#7", "B7", "C8"):
            noteName = "B7"
        case near("B7", "C8", "C#8"):
            noteName = "C8"
        case near("C8", "C#8", "D8"):
            noteName = "C#8/Db8"
        case near("C#8", "D8", "D#8"):
            noteName = "D8"
        case near("D8", "D#8", "E8"):
            noteName = "D#8/Eb8"
        case near("D#8", "E8", "F8"):
            noteName = "E8"
        case near("E8", "F8", "F#8"):
            noteName = "F8"
        case near("F8", "F#8", "G8"):
            noteName = "F#8/Gb8"
        case near("F#8", "G8", "G#8"):
            noteName = "G8"
        case near("G8", "G#8", "A8"):
            noteName = "G#8/Ab8"
        case near("G#8", "A8", "A#8"):
            noteName = "A8"
        case near("A8", "A#8", "B8"):
            noteName = "A#8/Bb8"
        case halfway("A#8", "B8")..<8000:
            noteName = "B8"
        default:
            noteName = nil
        }
        return noteName
    }
}
