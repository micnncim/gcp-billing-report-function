package function

import (
	"context"
	"encoding/json"
	"log"
)

type PubSubMessage struct {
	Data []byte `json:"data"`
}

type Data struct {
	CostAmount   float64 `json:"costAmount"`
	BudgetAmount float64 `json:"budgetAmount"`
}

func F(ctx context.Context, m PubSubMessage) error {
	log.Println("gcp-billing-report-function triggered")

	data := &Data{}
	if err := json.Unmarshal(m.Data, data); err != nil {
		return err
	}
	log.Printf("cost-amount=%d, budget-amount=%d", int(data.CostAmount), int(data.BudgetAmount))

	return nil
}
