-- CreateTable
CREATE TABLE "dish" (
    "dishID" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(64) NOT NULL,
    "description" VARCHAR(256),
    "price" DECIMAL(15,4) NOT NULL,
    "currency" VARCHAR(64) NOT NULL,
    "dishTypeID" VARCHAR(8) NOT NULL,
    "sessionID" UUID NOT NULL,
    "userID" VARCHAR(128) NOT NULL,

    CONSTRAINT "dish_pkey" PRIMARY KEY ("dishID")
);

-- CreateTable
CREATE TABLE "dishType" (
    "dishTypeID" VARCHAR(8) NOT NULL,
    "name" VARCHAR(64) NOT NULL,

    CONSTRAINT "dishType_pkey" PRIMARY KEY ("dishTypeID")
);

-- CreateTable
CREATE TABLE "role" (
    "roleID" VARCHAR(8) NOT NULL,
    "name" VARCHAR(64) NOT NULL,
    "description" VARCHAR(256),

    CONSTRAINT "role_pkey" PRIMARY KEY ("roleID")
);

-- CreateTable
CREATE TABLE "session" (
    "sessionID" UUID NOT NULL DEFAULT gen_random_uuid(),
    "title" VARCHAR(128) NOT NULL,
    "description" TEXT,
    "userID" VARCHAR(128) NOT NULL,
    "creationDate" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "session_pkey" PRIMARY KEY ("sessionID")
);

-- CreateTable
CREATE TABLE "user" (
    "userID" VARCHAR(128) NOT NULL,
    "email" VARCHAR(128) NOT NULL,
    "name" VARCHAR(128) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("userID")
);

-- CreateTable
CREATE TABLE "userRole" (
    "userID" VARCHAR(128) NOT NULL,
    "roleID" VARCHAR(8) NOT NULL,

    CONSTRAINT "pk_userrole" PRIMARY KEY ("userID","roleID")
);

-- CreateTable
CREATE TABLE "vote" (
    "dishID" UUID NOT NULL,
    "userID" VARCHAR(128) NOT NULL,
    "note" INTEGER NOT NULL,

    CONSTRAINT "pk_vote" PRIMARY KEY ("dishID","userID")
);

-- CreateIndex
CREATE UNIQUE INDEX "dishType_name_key" ON "dishType"("name");

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- AddForeignKey
ALTER TABLE "dish" ADD CONSTRAINT "fk_dishtypeid" FOREIGN KEY ("dishTypeID") REFERENCES "dishType"("dishTypeID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish" ADD CONSTRAINT "fk_sessionid" FOREIGN KEY ("sessionID") REFERENCES "session"("sessionID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dish" ADD CONSTRAINT "fk_userid" FOREIGN KEY ("userID") REFERENCES "user"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "fk_userid" FOREIGN KEY ("userID") REFERENCES "user"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userRole" ADD CONSTRAINT "fk_roleid" FOREIGN KEY ("roleID") REFERENCES "role"("roleID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userRole" ADD CONSTRAINT "fk_userid" FOREIGN KEY ("userID") REFERENCES "user"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vote" ADD CONSTRAINT "fk_dishid" FOREIGN KEY ("dishID") REFERENCES "dish"("dishID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vote" ADD CONSTRAINT "fk_userid" FOREIGN KEY ("userID") REFERENCES "user"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

