import { z } from "zod";

import {
  createTRPCRouter,
  protectedProcedure,
  publicProcedure,
} from "@/server/api/trpc";

import { eq, and, or, like } from "drizzle-orm";

import { db } from "@/server/db";

import { userTable } from "@/server/db/schema";

export const authRouter = createTRPCRouter({
  getAll: publicProcedure.query(async () => {
    return await db.select().from(userTable);
  }),
  getByUserId: publicProcedure.input(z.string()).query(async ({ input }) => {
    return await db.select().from(userTable).where(eq(userTable.userId, input));
  }),
  createUser: publicProcedure
    .input(
      z.object({
        email: z.string().email(),
        password: z.string().min(8),
        role: z.enum(["customer", "merchant", "admin"]).default("customer"),
      }),
    )
    .mutation(async ({ input }) => {
      const { email, password, role } = input;
      const newUser = await db
        .insert(userTable)
        .values({
          email,
          password, // Consider hashing the password before storing it
          role,
        })
        .returning();
      return newUser;
    }),
});
