(ns stats.two_dice
  (:gen-class)
  (:require [clojure.math.combinatorics :as combo]))

(defn dice ([n] (range 1 (+ 1 n))))

(defn print_dice ([dices] 
  (if (not-empty dices)
    (do
      (println (dice (read-string (first dices))))
      (print_dice (rest dices))))))

(defn combinations ([dice1_sides, dice2_sides]
  (combo/cartesian-product (dice dice1_sides) (dice dice2_sides))))

(defn combinations_containing_n ([dice1_sides, dice2_sides, n]
  (filter 
    (fn [combination] 
      (some #(= n %) combination))
    (combinations dice1_sides dice2_sides))))

(defn probability_at_least_one_dice_is_n ([dice1_sides, dice2_sides, n]
  [(count (combinations_containing_n dice1_sides dice2_sides n))
   (count (combinations dice1_sides dice2_sides))]))

(defn usage []
  "Usage:
    lein -m stats.two_dice [dice1_sides] [dice2_sides] [value]")

(defn -main
  "Rolls two dice"
  [& args]
  ;; work around dangerous default behaviour in Clojure
  (alter-var-root #'*read-eval* (constantly false))

  (if (= 3 (count args))
    (let [dice1_sides (read-string (first args))
          dice2_sides (read-string (second args))
          value       (read-string (last args))]
      (println (probability_at_least_one_dice_is_n dice1_sides dice2_sides value)))
    (println (usage))))
