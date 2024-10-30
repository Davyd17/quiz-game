-- Seeding Roles
INSERT INTO roles (name) VALUES
('admin'),
('gamer');

-- Seeding Permissions
INSERT INTO permissions (name) VALUES
('CREATE_GAME'),
('READ_GAME'),
('UPDATE_GAME'),
('DELETE_GAME');

-- Seeding Roles-Permissions Associations
-- Assuming role_id 1 is 'admin' and role_id 2 is 'gamer'
INSERT INTO roles_permissions (roles_id, permissions_id) VALUES
(1, 1), -- admin can CREATE_GAME
(1, 2), -- admin can READ_GAME
(1, 3), -- admin can UPDATE_GAME
(1, 4), -- admin can DELETE_GAME
(2, 2); -- gamer can READ_GAME

-- Seeding Users
-- Assigning role_id 1 (admin) to 'admin_user' and role_id 2 (gamer) to 'gamer1', 'gamer2'
INSERT INTO users (username, password, email, role_id) VALUES
('admin_user', 'hashedpassword1', 'admin@example.com', 1),
('gamer1', 'hashedpassword2', 'gamer1@example.com', 2),
('gamer2', 'hashedpassword3', 'gamer2@example.com', 2);

-- Seeding Rounds
-- Setting unique levels for each category
INSERT INTO rounds (category, level) VALUES
('Science', 1),
('Math', 2),
('History', 3);

-- Seeding Games
-- Using the trigger to set default round_id to the round with level = 1 (Science)
-- Assigning 'gamer1' and 'gamer2' to the games
INSERT INTO games (accumulated_points, user_id) VALUES
(1500, 2), -- This will auto-assign round_id where level = 1
(2000, 3); -- This will auto-assign round_id where level = 1

-- Seeding Questions
-- Adding questions to the 'Science' and 'Math' categories
INSERT INTO questions (content, round_id) VALUES
('What is the chemical symbol for water?', 1), -- Science category
('What is 2+2?', 2), -- Math category
('Who discovered america', 3); --History category

-- Seeding Answers
-- Associating answers with the correct questions (multiple-choice a, b, c, d)

-- Question 1 ("What is the chemical symbol for water?")
INSERT INTO answers (content, is_correct, question_id) VALUES
('a. H2O', TRUE, 1),
('b. CO2', FALSE, 1),
('c. H2', FALSE, 1),
('d. O2', FALSE, 1);

-- Question 2 ("What is 2+2?")
INSERT INTO answers (content, is_correct, question_id) VALUES
('a. 3', FALSE, 2),
('b. 4', TRUE, 2),
('c. 5', FALSE, 2),
('d. 22', FALSE, 2);

-- Question 3 ("Who discovered america?")
INSERT INTO answers (content, is_correct, question_id) VALUES
('a. Cristiano Ronaldo', FALSE, 3),
('b. Napoleon Hill', FALSE, 3),
('c. Cristobal Colon', TRUE, 3),
('d. Frida Khalo', FALSE, 3);