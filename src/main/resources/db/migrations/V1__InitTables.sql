CREATE TABLE "roles" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE "permissions" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL
);

CREATE TABLE "roles_permissions" (
  "roles_id" SERIAL,
  "permissions_id" SERIAL,
  PRIMARY KEY ("roles_id", "permissions_id")
);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR(30) UNIQUE NOT NULL,
  "password" VARCHAR(50) NOT NULL,
  "email" VARCHAR(50) UNIQUE NOT NULL,
  "role_id" INTEGER REFERENCES roles(id) ON DELETE SET NULL
);

CREATE TABLE "rounds" (
  "id" SERIAL PRIMARY KEY,
  "category" VARCHAR(50) UNIQUE NOT NULL,
  "level" SMALLINT UNIQUE NOT NULL
);

CREATE TABLE "games" (
  "id" SERIAL PRIMARY KEY,
  "accumulated_points" int NOT NULL DEFAULT 0,
  "user_id" INTEGER UNIQUE REFERENCES users(id),
  "round_id" SMALLINT REFERENCES rounds(id)
);

CREATE TABLE "questions" (
  "id" SERIAL PRIMARY KEY,
  "content" VARCHAR(300) NOT NULL,
  "round_id" INTEGER REFERENCES rounds(id) ON DELETE CASCADE
);

CREATE TABLE "answers" (
  "id" SERIAL PRIMARY KEY,
  "content" VARCHAR(300) NOT NULL,
  "is_correct" BOOLEAN NOT NULL,
  "question_id" INTEGER REFERENCES questions(id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION set_default_round()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.round_id IS NULL THEN
     -- Set round_id where difficulty_level = 1
    SELECT id INTO NEW.round_id FROM rounds WHERE level = 1 LIMIT 1;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER set_default_round_trigger
BEFORE INSERT ON games
FOR EACH ROW
EXECUTE FUNCTION set_default_round();
