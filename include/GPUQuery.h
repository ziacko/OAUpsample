#ifndef GPU_QUERY_H
#define GPU_QUERY_H

class GPUTimer
{
public:
	GPUTimer()
	{
		glGenQueries(1, &queryID);
		Begin();
	}

	~GPUTimer()
	{
		End();
		glDeleteQueries(1, &queryID);
	}

	void Begin()
	{
		if (started)
			glEndQuery(GL_TIME_ELAPSED);

		glBeginQuery(GL_TIME_ELAPSED, queryID);
		started = true;
	}

	void End()
	{
		if (!started)
			return;

		glEndQuery(GL_TIME_ELAPSED);
		started = false;
	}

	double GetTimeSeconds()
	{
		GetResult();
		return static_cast<double>(result) / 1000000000.0;
	}

	double GetTimeMilliseconds()
	{
		GetResult();
		return static_cast<double>(result) / 1000000.0;
	}

	unsigned long GetTimeNanoseconds()
	{
		GetResult();
		return result;
	}

private:
	void GetResult()
	{
		if (hasResult)
		{
			//return;
		}
		if (started)
		{
			End();
		}

		//glGetInteger64v(gl_timestamp, &result);
		glGetQueryObjectuiv(queryID, GL_QUERY_RESULT, &result);
		hasResult = true;
	}

	GLuint queryID;
	GLuint result = 0;
	bool started = false;
	bool hasResult = false;
};

#endif