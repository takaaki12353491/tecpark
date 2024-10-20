import { json, LoaderFunction } from "@remix-run/node";
import { useLoaderData } from "@remix-run/react";

type User = {
  id: number;
  name: string;
};

type LoaderData = {
  users: User[];
};

export const loader: LoaderFunction = () => {
  const users: User[] = [
    { id: 1, name: "太郎" },
    { id: 2, name: "花子" },
    { id: 3, name: "次郎" }
  ];
  return json<LoaderData>({ users });
};

export default function Index() {
  const { users } = useLoaderData<LoaderData>();

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}