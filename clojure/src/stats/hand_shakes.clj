(ns stats.hand_shakes
  (:gen-class)
  (:require [clojure.math.combinatorics :as combo]))

(defn combination-count [number_of_people]
  (count (combo/combinations (range 0 number_of_people) 2)))

(defn usage []
  "Usage: 
    lein -m stats.hand_shakes [number_of_people]")

(defn -main
  "How many unique hand shakes with n people"
  [& args]
  ;; work around dangerous default behaviour in Clojure
  (alter-var-root #'*read-eval* (constantly false))

  (if (= 1 (count args))
    (let [number_of_people (read-string (first args))]
      (println (combination-count number_of_people)))
    (println (usage))))
