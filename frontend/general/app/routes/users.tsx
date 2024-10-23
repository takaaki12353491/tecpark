import { json } from "@remix-run/node";
import { useLoaderData } from "@remix-run/react";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function loader() {
	const users = await prisma.users.findMany();
	return json({ users });
}

export default function Index() {
	const { users } = useLoaderData<typeof loader>();

	return (
		<ul>
			{users.map((user) => (
				<li key={user.id}>{user.nickname}</li>
			))}
		</ul>
	);
}
