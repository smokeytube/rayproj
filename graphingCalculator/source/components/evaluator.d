module components.evaluator;

import std;
import std.math.operations : feqrel;
import std.math.constants : E;

struct Evaluator
{

	double xValue = 0;

private:

	string expr;
	size_t index = 0;

	public this(string expr, double x)
	{
		this.expr = expr;
		xValue = x;
	}

	bool eof()
	{
		return index == expr.length;
	}

	void skipWhitespace()
	{
		while (!eof && expr[index] == ' ')
			index++;
	}

	double atom()
	{
		skipWhitespace();
		if (expr[index] == 'x')
		{
			index += 1;
			return xValue;
		}
		// // natural log
		// else if (expr[index] == 'a' && expr[index+1] == '(')
		// {
		// 	index += 2;
		// 	double value = log(eval(0));
		// 	if (eof || expr[index++] != ')')
		// 		throw new Exception("expected ')' to close parenthetical expression");
		// 	return value;
		// }
		else if (expr[index] == '(')
		{
			index += 1;
			double value = eval(0);
			if (eof || expr[index++] != ')')
				throw new Exception("expected ')' to close parenthetical expression");
			return value;
		}
		else
		{
			bool hasDot = false;
			int decPlaces = 0;
			double res = 0;
			bool first = true;
			while (!eof)
			{
				char ch = expr[index];
				if (ch == '.' && !hasDot)
				{
					index += 1;
					hasDot = true;
				}
				else if (ch >= '0' && ch <= '9')
				{
					index += 1;
					if (hasDot)
						decPlaces += 1;
					res *= 10;
					res += ch - '0';
				}
				else
				{
					if (first)
						throw new Exception("expected number, got character '" ~ ch ~ "'");
					else
						break;
				}
				first = false;
			}
			if (decPlaces == 0)
				return res;
			else
				return res / pow(10.0, decPlaces);
		}
	}

	double eval(int minPrec)
	{
		double lhs = atom();

		while (true)
		{
			skipWhitespace();
			if (eof)
				break;

			char op = expr[index];

			if (op == '+' && minPrec < 1)
			{
				index += 1;
				lhs = lhs + eval(1);
			}
			else if (op == '-' && minPrec < 1)
			{
				index += 1;
				lhs = lhs - eval(1);
			}
			else if (op == '*' && minPrec < 2)
			{
				index += 1;
				lhs = lhs * eval(2);
			}
			else if (op == '/' && minPrec < 2)
			{
				index += 1;
				lhs = lhs / eval(2);
			}
			else if (op == '^' && minPrec < 2)
			{
				index += 1;
				lhs = pow(lhs, eval(2));
			}
			else if (op == '%' && minPrec < 2)
			{
				index += 1;
				lhs = lhs % eval(2);
			}
			else
			{
				break;
			}
		}

		return lhs;
	}

	public double eval()
	{
		double res = eval(0);
		if (!eof)
			throw new Exception("expected eof");
		return res;
	}

}

bool same(double a, double b)
{
	return a == b || (isNaN(a) && isNaN(b));
}

// void main()
// {
// 	foreach (double x; -10 .. 10)
// 	{
// 		assert(same(Evaluator("x*(x + 3) - x", x).eval, (x * (x + 3) - x)));
// 		assert(same(Evaluator("x*x*x-3*x", x).eval, (x * x * x - 3 * x)));
// 		assert(same(Evaluator("x*x/x-3*x", x).eval, (x * x / x - 3 * x)));
// 		assert(same(Evaluator("3/x-6", x).eval, (3 / x - 6)));
// 		assert(same(Evaluator("3/x-6+7-6+8-3", x).eval, (3 / x - 6 + 7 - 6 + 8 - 3)));
// 		assert(same(Evaluator("3/x-6+7-x+8-3", x).eval, (3 / x - 6 + 7 - x + 8 - 3)));
// 		assert(same(Evaluator("3/x*x+8-3", x).eval, (3 / x * x + 8 - 3)));
// 		assert(same(Evaluator("3/(x*x+8)-3", x).eval, (3 / (x * x + 8) - 3)));
// 		assert(same(Evaluator("3/(x*((x))+8)-3", x).eval, (3 / (x * ((x)) + 8) - 3)));
// 		assert(same(Evaluator("3/(x*((x)+5)+8)-3", x).eval, (3 / (x * ((x) + 5) + 8) - 3)));
// 	}
// }
