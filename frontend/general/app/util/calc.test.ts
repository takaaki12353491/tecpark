import { expect, test, describe } from "bun:test";
import { add } from "@/util/calc";

describe("add", () => {
	test("合計を返す", () => {
		const result = add(2, 2);
		expect(result).toBe(4);
	});
});
