-- DROP TABLE IF EXISTS public."vote" CASCADE;
-- DROP TABLE IF EXISTS public."dish" CASCADE;
-- DROP TABLE IF EXISTS public."dishType" CASCADE;
-- DROP TABLE IF EXISTS public."session" CASCADE;
-- DROP TABLE IF EXISTS public."userRole" CASCADE;
-- DROP TABLE IF EXISTS public."role" CASCADE;
-- DROP TABLE IF EXISTS public."user" CASCADE;

------------
--- user ---
------------

CREATE TABLE public."user" (
    "userID" VARCHAR(128) PRIMARY KEY,      -- Auth0 userID
    "email" VARCHAR(128) UNIQUE NOT NULL,   -- Auth0 email
    "name" VARCHAR(128) NOT NULL            -- Auth0 name
);

----------
-- role --
----------

CREATE TABLE public."role" (
    "roleID" VARCHAR(8) PRIMARY KEY,        -- R1, R2, etc.
    "name" VARCHAR(64) UNIQUE NOT NULL,
    "description" VARCHAR(256)
);

-----------------
-- user x role --
-----------------

CREATE TABLE public."userRole" (
    "userID" VARCHAR(128) NOT NULL, -- FK
    "roleID" VARCHAR(8) NOT NULL,   -- FK
    -- FK userID --
    CONSTRAINT fk_userID FOREIGN KEY ("userID") 
    REFERENCES public."user" ("userID") 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
    -- FK roleID --
    CONSTRAINT fk_roleID FOREIGN KEY ("roleID") 
    REFERENCES public."role" ("roleID") 
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    -- Primary Key
    CONSTRAINT pk_userRole PRIMARY KEY ("userID", "roleID")
);

---------------
--- session ---
---------------

CREATE TABLE public."session" (
    "sessionID" UUID DEFAULT gen_random_uuid () PRIMARY KEY,
    "title" VARCHAR(128) NOT NULL,
    "description" TEXT,
    "userID" VARCHAR(128) NOT NULL,     -- FK
    "creationDate" TIMESTAMP DEFAULT NOW(),
    -- FK userID --
    CONSTRAINT fk_userID FOREIGN KEY ("userID")
    REFERENCES public."user"("userID")
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

--------------
-- dishType --
--------------

CREATE TABLE public."dishType" (
    "dishTypeID" VARCHAR(8) PRIMARY KEY, -- T1, T2, T3, etc
    "name" VARCHAR(64) UNIQUE NOT NULL
);

----------
-- dish --
----------

CREATE TABLE public."dish" (
    "dishID" UUID DEFAULT gen_random_uuid () PRIMARY KEY,
    "name" VARCHAR(64) NOT NULL,
    "description" VARCHAR(256),
    "price" NUMERIC(15, 4) NOT NULL, -- 15 digits, 4 decimals
    "currency" VARCHAR(64) NOT NULL,
    "dishTypeID" VARCHAR(8) NOT NULL, -- FK
    "sessionID" UUID NOT NULL, -- FK
    "userID" VARCHAR(128) NOT NULL, -- FK
    -- FK dishTypeID --
    CONSTRAINT fk_dishTypeID FOREIGN KEY ("dishTypeID") 
    REFERENCES public."dishType" ("dishTypeID") 
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    -- FK sessionID --
    CONSTRAINT fk_sessionID FOREIGN KEY ("sessionID")
    REFERENCES public."session" ("sessionID")
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    -- FK userID --
    CONSTRAINT fk_userID FOREIGN KEY ("userID")
    REFERENCES public."user" ("userID")
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

----------
-- vote --
----------

CREATE TABLE public."vote" (
    "dishID" UUID NOT NULL, -- FK
    "userID" VARCHAR(128) NOT NULL, -- FK
    "note" INT NOT NULL,
    -- FK dishID --
    CONSTRAINT fk_dishID FOREIGN KEY ("dishID") 
    REFERENCES public."dish" ("dishID") 
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    -- FK userID --
    CONSTRAINT fk_userID FOREIGN KEY ("userID")
    REFERENCES public."user" ("userID")
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    -- Primary Key --
    CONSTRAINT pk_vote 
    PRIMARY KEY ("dishID", "userID")
);

-----------
-- SEEDS --
-----------

INSERT INTO	public."role" ("roleID", "name", "description") VALUES
	(
		'R1',
		'Standard',
		'Basic access with limited permissions.'
	),
	(
		'R2',
		'Business',
		'Extended access for business features and tools.'
	),
	(
		'R3',
		'Admin',
		'Full access with administrative privileges.'
	);

INSERT INTO public."dishType" ("dishTypeID", "name") VALUES 
    ('T1', 'Starter'),
    ('T2', 'Main'),
    ('T3', 'Dessert'),
    ('T4', 'Side'),
    ('T5', 'Drink'),
    ('T6', 'Appetizer'),
    ('T7', 'Soup'),
    ('T8', 'Salad'),
    ('T9', 'Cheese'),
    ('T10', 'Bread'),
    ('T11', 'Sauce');
