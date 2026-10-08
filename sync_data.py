import pandas as pd, numpy as np
np.random.seed(42)
num_candidates = 5500
sources = ['LinkedIn','Naukri','Referral','CareerSite','Agency']
source_probs = [0.4,0.25,0.2,0.1,0.05]
start_date = pd.to_datetime("2023-01-01")
end_date = pd.to_datetime("2026-01-01")
date_range = (end_date - start_date).days

touchpoints = []
funnel_events = []
candidates = []

for cid in range(1, num_candidates+1):
    # Generate 1-3 touchpoints before application
    num_touches = np.random.choice([1,2,3], p=[0.6,0.3,0.1])
    touch_dates = sorted([start_date + pd.Timedelta(days=int(np.random.rand()*date_range))
                          for _ in range(num_touches)])
    for order, td in enumerate(touch_dates, 1):
        src = np.random.choice(sources, p=source_probs)
        touchpoints.append((cid, order, src, td))
    # Application event after last touch
    apply_date = touch_dates[-1] + pd.Timedelta(days=int(np.random.exponential(10)))
    apply_date = min(apply_date, end_date)
    funnel_events.append((cid, 'Applied', apply_date))
    # Screening (~70% chance)
    if np.random.rand() < 0.7:
        screen_date = apply_date + pd.Timedelta(days=int(np.random.exponential(7)))
        funnel_events.append((cid, 'Screened', screen_date))
        # Interview (~50% chance)
        if np.random.rand() < 0.5:
            interview_date = screen_date + pd.Timedelta(days=int(np.random.exponential(14)))
            funnel_events.append((cid, 'Interviewed', interview_date))
            # Offer (~30% chance)
            if np.random.rand() < 0.3:
                offer_date = interview_date + pd.Timedelta(days=int(np.random.exponential(7)))
                funnel_events.append((cid, 'Offered', offer_date))
                # Hire (~80% accept)
                if np.random.rand() < 0.8:
                    hire_date = offer_date + pd.Timedelta(days=int(np.random.exponential(5)))
                    funnel_events.append((cid, 'Hired', hire_date))
                    accepted_flag = True
                else:
                    accepted_flag = False
            else:
                accepted_flag = False
        else:
            accepted_flag = False
    else:
        accepted_flag = False
    # Candidate profile
    roles = ['Data Analyst','Software Engineer','Product Manager','HR Specialist','Sales Executive']
    locations = ['Bangalore','Pune','Mumbai','Delhi','Chennai']
    exp = np.random.choice(['Entry','Mid','Senior'])
    edu = np.random.choice(['Bachelor','Master','PhD','Diploma'])
    # Primary source = first touch's source
    first_source = touchpoints[-num_touches][2] if num_touches>0 else None
    candidates.append((cid, np.random.choice(roles), np.random.choice(locations),
                       exp, edu, first_source, apply_date))
# Create DataFrames
candidates_df = pd.DataFrame(candidates, columns=['candidate_id','role','location','experience','education','first_source','application_date'])
touchpoints_df = pd.DataFrame(touchpoints, columns=['candidate_id','touch_order','source','touch_date'])
events_df = pd.DataFrame(funnel_events, columns=['candidate_id','stage','event_date'])
# Costs per source (example monthly budget)
source_costs_df = pd.DataFrame({'source': sources, 'monthly_cost': [12000, 8000, 1000, 3000, 10000]})

print(candidates_df.head(5))
print(candidates_df.shape)
print(touchpoints_df.head(5))
print(touchpoints_df.shape)
print(events_df.head(5))
print(events_df.shape)
print(source_costs_df)

candidates_df.to_csv('candidates.csv', index=False)
touchpoints_df.to_csv('touchpoints.csv', index=False)
events_df.to_csv('events.csv', index=False)
source_costs_df.to_csv('source_costs.csv', index=False)
print("CSV files saved.")
# This code generates synthetic data for a recruitment funnel, including candidate profiles, touchpoints, and funnel events. The data is saved to CSV files for further analysis.
