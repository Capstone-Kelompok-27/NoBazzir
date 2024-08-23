"use client";

import React from "react";
import { api } from "@/trpc/react";

const Test = () => {
  const createUser = api.auth.createUser.useMutation();
  function clickHandler() {
    createUser.mutate({
      email: "mutationtesting@gmail.com",
      password: "mutasikeren",
      role: "customer",
    });
  }
  return (
    <div>
      <button onClick={clickHandler}>Submit</button>
    </div>
  );
};

export default Test;
