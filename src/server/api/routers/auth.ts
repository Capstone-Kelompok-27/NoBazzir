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
  editUser: protectedProcedure
    .input(
      z.object({
        userId: z.string().uuid(),
        email: z.string().email().optional(),
        password: z.string().min(8).optional(),
        role: z.enum(["customer", "merchant", "admin"]).optional(),
      }),
    )
    .mutation(async ({ input }) => {
      const {userId, email, password, role} = input;

      const updateFields: any = {};
      if (email) updateFields.email = email;
      if (password) updateFields.password = password; // to-do: nant dihash
      if (role) updateFields.role = role;

      const updatedUser = await db
        .update(userTable)
        .set(updateFields)
        .where(eq(userTable.userId, userId))
        .returning();
      
      return updatedUser;
    }),
  deleteUser: protectedProcedure
    .input(z.string().uuid())
    .mutation(async ({ input }) => {
      const userId = input;

      // Optionally handle dependent data deletion or adjustments here
      await db.delete(userTable).where(eq(userTable.userId, userId));

      return { success: true };
    }),
});
