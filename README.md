# README

## Versions

- ruby **3.3.0.preview2**
- rails **7.0.8**
- postgres **14**

## HOW TO START

- clone project
  ```bash
  git clone git@github.com:kolan4ick/TaskProAPI.git
  cd TaskProAPI
  ```

- install ruby and RVM if need
  ```bash
  bundle
  cp .env-template .env
  ```

- change *.env* file if need product env
- create db and run migrates
  ```bash
  rails db:setup
  ```

- Run project

  ```bash
  rails s
  ```