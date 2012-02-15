module mvector4d;

static import std.stdio;

template tvector4d(T)
{
  class vector4d_
  {
  public:
    T x = void;
    T y = void;
    T z = void;
    T w = void;
      
    this()
    {
    }

    this(vector4d_ v)
    {
      x = v.x;
      y = v.y;
      z = v.z;
      w = v.w;
    }

    this(T* p)
    {
      x = p[0];
      y = p[1];
      z = p[2];
      w = p[3];
    }

    this(T[] a)
    {
      x = a[0];
      y = a[1];
      z = a[2];
      w = a[3];
    }

    void writeln()
    {
      std.stdio.writeln("[", x, ", ", y, ", ", z, ", ", w, "]");
    }

    this(T xx, T yy, T zz, T ww)
    {
      x = xx;
      y = yy;
      z = zz;
      w = ww;
    }

    vector4d_ opUnary(string s)() if (s == "-")
      {
	return new vector4d_(-x, -y, -z, -w);
      }

    vector4d_ opUnary(string s)() if (s == "+")
      {
	return new vector4d_(this);
      }

    vector4d_ opOpAssign(string s)(vector4d_ rgh) if (s == "+")
      {
	x += rgh.x;
	y += rgh.y;
	z += rgh.z;
	w += rgh.w;

	return this;
      }

    vector4d_ opOpAssign(string s)(vector4d_ rgh) if (s == "-")
      {
	x -= rgh.x;
	y -= rgh.y;
	z -= rgh.z;
	w -= rgh.w;

	return this;
      }

    vector4d_ opOpAssign(string s)(T k) if (s == "*")
      {
	x *= k;
	y *= k;
	z *= k;
	w *= k;

	return this;
      }

    vector4d_ opOpAssign(string s)(T k) if (s == "/")
      {
	x /= k;
	y /= k;
	z /= k;
	w /= k;

	return this;
      }

    vector4d_ opBinary(string s)(vector4d_ rgh) if (s == "+")
      {
	vector4d_ v = new vector4d_(this);
	return v += rgh;
      }

    vector4d_ opBinary(string s)(vector4d_ rgh) if (s == "-")
      {
	vector4d_ v = new vector4d_(this);
	return (v -= rgh);
      }

    vector4d_ opBinary(string s)(T k) if (s == "*")
      {
	vector4d_ v = new vector4d_(this);
	return v *= k;
      }

    vector4d_ opBinaryRight(string s)(T k) if (s == "*")
      {
	return new vector4d_(k * x, k * y, k * z, k * w);
      }

    vector4d_ opBinary(string s)(T k) if (s == "/")
      {
	auto v = this;
	return v /= k;
      }

    T opBinary(string s) (vector4d_ rgh) if (s == "*")
      {
	return x * rgh.x + y * rgh.y + z * rgh.z + w * rgh.w;
      }

    // Constructors test
    unittest
    {
      vector4d_ v1 = new vector4d_(1.0f, 2.0f, 3.0f, 4.0f);
      vector4d_ v2 = v1;
      v1.x = 2.0f;

      assert(v1.x != v2.x);
    }
  }
}