(ns stats.two_dice
  (:gen-class)
  (:require [clojure.math.combinatorics :as combo]))

(use '[clojure.tools.cli :only [cli]])

; Utilities

(defmacro fmt [^String string]
  (let [-re #"#\{(.*?)\}"
        fstr (clojure.string/replace string -re "%s")
        fargs (map #(read-string (second %)) (re-seq -re string))]
    `(format ~fstr ~@fargs)))

; Probability Calculations

(defn dice ([n] (range 1 (+ 1 n))))

(defn combinations ([dice1_sides dice2_sides]
  (combo/cartesian-product (dice dice1_sides) (dice dice2_sides))))

(defn combinations_both_are_n ([dice1_sides dice2_sides n] 
  (filter
    (fn [combination]
      (every? #(= n %) combination))
    (combinations dice1_sides dice2_sides))))

(defn combinations_containing_n ([dice1_sides dice2_sides n]
  (filter 
    (fn [combination] 
      (some #(= n %) combination))
    (combinations dice1_sides dice2_sides))))

(defn probability_both_are ([dice1_sides dice2_sides n]
  [(count (combinations_both_are_n dice1_sides dice2_sides n))
   (count (combinations            dice1_sides dice2_sides))]))

(defn probability_roll_contains ([dice1_sides dice2_sides n]
  [(count (combinations_containing_n dice1_sides dice2_sides n))
   (count (combinations              dice1_sides dice2_sides))]))

; Application runtime support

(defn parse_options [args]
  (cli args
     ["-b" "--black"     "Number of sides on black dice" :default 6 :parse-fn #(Integer. %)]
     ["-w" "--white"     "Number of sides on white dice" :default 6 :parse-fn #(Integer. %)]
     ["-o" "--both"      "Probability both rolls are [value]"       :parse-fn #(Integer. %)]
     ["-c" "--contains"  "Probability rolls conatain [value]"       :parse-fn #(Integer. %)]
     ))

(defn -main
  "Rolls two dice"
  [& args]
  ;; work around dangerous default behaviour in Clojure
  (alter-var-root #'*read-eval* (constantly false))

  (let [parsed_options (parse_options args)
        options        (first parsed_options)
        usage          (last  parsed_options)]
    (if (= 0 (count args))
      (println usage)
      (do
        (println (fmt "Two Dice: {:black => #{(:black options)}, :white => #{(:white options)}}"))

        (if (:both options)
          (println (fmt "both #{(:both options)}: #{(apply probability_both_are ((juxt :black :white :both) options))}")))
        (if (:contains options)
          (println (fmt "contains #{(:contains options)}: #{(apply probability_roll_contains ((juxt :black :white :contains) options))}")))
        ))))

    ; puts "both #{options[:both]}: #{@two_dice.probability_both_are options[:both]}" if options[:both]

; Usage: two_dice [options]
;     -b, --black=[sides]
;     -w, --white=[sides]
;     -o, --both=[value]
;     -c, --contains=[value]
;     -a, --same
;     -s, --sum=[value]
;         --less-than-or-equal-to=[value]
